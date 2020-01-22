vec3 hsv2rgb_smooth( in vec3 c )
{
    vec3 rgb = clamp( abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),6.0)-3.0)-1.0, 0.0, 1.0 );
	rgb = rgb*rgb*(3.0-2.0*rgb); // cubic smoothing
	return c.z * mix( vec3(1.0), rgb, c.y);
}

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

