//
//  ViewController.m
//  HelloOpenGL
//
//  Created by Ivan Magda on 17/06/2017.
//  Copyright © 2017 Ivan Magda. All rights reserved.
//

#import "GLViewController.h"

@interface GLViewController ()

@end

@implementation GLViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  GLKView *view = (GLKView *) self.view;
  view.context = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES2];
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClearColor(0.0, 104.0/255.0, 55.0/255.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT);
}

@end
