void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord.xy / iResolution.xy;
  float circle = sin(iGlobalTime*10.0f);
  fragColor = mix(texture(barTex, Texcoord), vec4(Color, 1.0f), 0.5);

  vec2 wiggleOffset = vec2(Texcoord.x, Texcoord.y + sin(Texcoord.x*80.0f+(iGlobalTime*20.0f))/8.0f ); 
  
  //fragColor = texture(barTex, wiggleOffset);
  fragColor = mix(texture(barTex, wiggleOffset), vec4(Color, 1.0f), 0.5);
  
//  fragColor = vec4(uv.x, uv.y, 0.5+0.5*sin(iGlobalTime), 1.0);
  // Draw bar without modifications
  //fragColor = texture(barTex, Texcoord);
}

