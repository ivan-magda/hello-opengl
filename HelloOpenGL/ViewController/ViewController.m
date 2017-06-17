/**
 * Copyright (c) 2017 Ivan Magda
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "ViewController.h"

#import "Vertex.h"
#import "BaseEffect.h"

typedef NS_ENUM(NSUInteger, ScreenColor) {
  kGreen,
  kBlack
};

@interface ViewController ()

@property (nonatomic, assign) ScreenColor screenColor;

@end

@implementation ViewController {
  GLuint _vertexBuffer;
  BaseEffect *_shader;
}

- (void)viewDidLoad {
  [super viewDidLoad];
    [self setup];
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  [self updateBackgroundColor];
  
  glEnableVertexAttribArray(VertexAttribPosition);
  glVertexAttribPointer(VertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
  
  glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
  glDrawArrays(GL_TRIANGLES, 0, 3);
  
  glDisableVertexAttribArray(VertexAttribPosition);
}

- (void)setup {
  GLKView *view = (GLKView *) self.view;
  view.context = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES2];
  [EAGLContext setCurrentContext:view.context];
  
  [self setupShader];
  [self setupVertexBuffer];
  
  UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
  [view addGestureRecognizer: tapRecognizer];
}

- (void)setupShader {
  _shader = [[BaseEffect alloc] initWithVertexShader:@"ShaderVertex"
                                      fragmentShader:@"ShaderFragment"];
}

- (void)setupVertexBuffer {
  const static Vertex vertices[] = {
    {{(GLfloat) -1.0, (GLfloat) -1.0, 0}},
    {{1.0, (GLfloat) -1.0, 0}},
    {{0.0, 0.0, 0}}
  };
  
  glGenBuffers(1, &_vertexBuffer);
  glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
}

- (void)updateBackgroundColor {
  switch (_screenColor) {
    case kBlack:
      glClearColor(0.0, 0.0, 0.0, 1.0);
      break;
    case kGreen:
      glClearColor(0.0, (GLfloat) (104.0/255.0), (GLfloat) (55.0/255.0), 1.0);
      break;
    default:
      NSLog(@"Receive incompatible color");
      break;
  }
  
  glClear(GL_COLOR_BUFFER_BIT);
}

-(void)onTap {
  switch (_screenColor) {
    case kBlack:
      _screenColor = kGreen;
      break;
    case kGreen:
      _screenColor = kBlack;
      break;
  }
  
  [self updateBackgroundColor];
}

@end
