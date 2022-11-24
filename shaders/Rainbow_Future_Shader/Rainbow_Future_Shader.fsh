uniform float vTime;
uniform float vSwitch;
uniform float yOffset;

varying vec2 v_vTexcoord;
uniform vec3 vRes;
varying vec4 v_vColour;

void main(){
    vec2 uv = v_vTexcoord.xy;
    float cor = (vRes.x / vRes.y);
    float ra = 1.0 + (cos(vTime/60.0))/10.0;
    float rs = 1.0 - (sin(vTime/30.0))/10.0;
    vec2 p =  v_vTexcoord.xy * 1.5;
    p.x *= cor;
    float a = atan(p.x,p.y);
    float r = length(p) * ra;
    
    //squigly line
    if(vSwitch == 0.0){
        uv.y *= 2.0 + (sin((uv.x*10.0) + (vTime/30.0))) / (2.0 / (sin(vTime/30.0)/10.0)) - .5 - yOffset;
        uv.x *= cor;
    }
    
    //curved line
    if(vSwitch == 1.0){
        uv = (v_vTexcoord.xy) * vec2((a)/(3.1415926535),r) / 0.5 -.5 - yOffset;
        uv.x *= cor;
    }
    
    //circle
    if(vSwitch == 2.0){
        uv = vec2((a)/(3.1415926535),r/2. - yOffset) ;// - center/100.0;
    }
    
    //diagonal line
    if(vSwitch == 3.0){
       uv.y += uv.x - .5 + yOffset; 
    }
    
    //squiggly diagonal line
    if(vSwitch == 4.0){
        uv.y += uv.x - .5 + yOffset;
        uv.y *= 2.0 + (sin((uv.x*10.0) + (vTime/30.0))) / (2.0 / (sin(vTime/30.0)/10.0)) - .5 - yOffset;
    }
    
    //fullscreen thingy
    if(vSwitch == 5.0){
        uv.y = .5;
    }
    
    //colors
    float verColor = (uv.x - (vTime / 120.0)) * 3.0;
    verColor = mod(verColor, 3.0);
    vec3 hc = vec3(0.25, 0.25, 0.25);
    
    if (verColor < 1.0) {
        hc.r += 1.0 - verColor;
        hc.g += verColor;
   }
    else if (verColor < 2.0) {
        verColor -= 1.0;
        hc.g += 1.0 - verColor;
        hc.b += verColor;
   }
    else {
        verColor -= 2.0;
        hc.b += 1.0 - verColor;
        hc.r += verColor;
   }

   //grid lines
   float bv = 1.0;
   if ((mod(uv.y * 110.0, 1.0) > 0.70 || mod(uv.x * 110.0 * cor, 1.0) > 0.70) && vSwitch != 5.0) {
        bv = 1.15 * ra;
   }

   //line
   uv = (2.0 * uv) - 1.0 / ra;
   float bw = abs(1.0 / (30.0 * uv.y)) * ra;
   vec3 hb = vec3(bw);
    
    gl_FragColor = vec4(((bv * hb) * hc), 1.0);
    }
