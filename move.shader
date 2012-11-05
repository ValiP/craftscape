/*
    :copyright: 2011 by Florian Boesch <pyalot@gmail.com>.
    :license: GNU AGPL3, see LICENSE for more details.
*/

vertex:
    attribute vec2 position;
	varying vec2 old_position;
	
    void main(){
		old_position = position / 2. +0.5;
		gl_Position = vec4(position, 0.0, 1.0);
    }

fragment:
    uniform sampler2D ground;
    uniform vec2 viewport;
	uniform float speed;
	
	varying vec2 old_position;
	
	vec2 arabic_plate = vec2(0.1,0.5);
	vec2 african_plate = vec2(-0.3,0.02);
	vec2 somalian_plate = vec2(0.147,-0.01);
    
    vec4 get(sampler2D source, vec2 dir){
        return texture2D(source, old_position+dir);
    }

    void main(void){
        vec2 direction;		
		
		if(old_position.y > pow(3.*old_position.x-0.9,4.)*3.+0.5 || old_position.x > 0.45 && old_position.y > 0.8*old_position.x+0.22) {
			direction = arabic_plate;
		}
		else if(old_position.y > (old_position.x+0.07) * 10. - 3.) direction = african_plate;
		else direction = somalian_plate;	

		vec4 g = get(ground, -direction * speed * 0.0002);
		
		if(old_position.x < 0.16 && old_position.x > 0.07 && old_position.y > 0.8) {
			if(old_position.y > 0.92) {
				if(g.y < 0.) g.y += 0.0001;
			} else g.y *= 0.96;
		}
		
        gl_FragColor = g;
    }
