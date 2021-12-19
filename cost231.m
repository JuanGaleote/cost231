function Lb = cost231(link_type,city_type,f,d,ht,hr,hroof,phi,w,b)

% cost231 - Calcula las pérdidas de un enlace usando el modelo COST-231.
% ······································································
% · ***INPUTS***                                                       ·
% ·  - link_type: Situación del enlace ('LOS' o 'NLOS').               ·
% ·  - city_type: Tipo de ciudad ('medium' o 'big').                   ·
% ·  -         f: Frecuencia de trabajo (Hz).                          ·
% ·  -         d: Distancia del enlace (m).                            ·
% ·  -        ht: Altura de la antena transmisora (m).                 ·
% ·  -        hr: Altura de la antena receptora (m).                   ·
% ·  -     hroof: Altura de los edificios (m).                         ·
% ·  -       phi: Ángulo rayo-calle en planta (º).                     ·
% ·  -         w: Anchura de las calles (m).                           ·
% ·  -         b: Distancia entre los edificios (m).                   ·
% ······································································
% · ***OUTPUTS***                                                      ·
% ·  -        Lb: Pérdidas del enlace (dB).                            ·
% ······································································

if strcmp(link_type,'LOS')

    % PÉRDIDAS EN SITUACIÓN LOS.
    Lb = 42.6 + 26*log10(d/1e3) + 20*log10(f/1e6);

elseif strcmp(link_type,'NLOS')

    % PÉRDIDAS EN SITUACIÓN NLOS.
    % Diferencias de altura entre antenas y edificios.
    dhr = hroof - hr;
    dhb = ht - hroof;
        
    % Pérdidas en el espacio libre.
    L0 = 32.5 + 20*log10(f/1e6) + 20*log10(d/1e3);

    % Pérdidas por difracción tejado-calle.
    if (0 <= phi) && (phi <= 35)
        Lori = -10 + 0.3593*phi;
    elseif (35 < phi) && (phi <= 55)
        Lori = 2.5 + 0.0075*(phi - 35);
    else
        Lori = 4 - 0.114*(phi - 35);
    end

    Lrts = -8.2 - 10*log10(w) + 10*log10(f/1e6) + 20*log10(dhr) + Lori;

    % Pérdidas por difracción multipantalla.
    if dhb >= 0
        Lbhs = -18*log10(1 + dhb);
        ka = 54;
        kd = 18;
    else
        Lbhs = 0;
        kd = 18 - 15*dhb/hroof;
        if d >= 0.5
            ka = 54 - 0.8*dhb;
        else
            ka = 54 - 1.6*dhb/d;
        end
    end

    if strcmp(city_type,'medium')
        kf = -4 + 0.7*(f/925e6 - 1);
    elseif strcmp(city_type,'big')
        kf = -4 + 0.15*(f/925e6 - 1);
    end

    Lmsd = Lbhs + ka + kd*log10(d/1e3) + kf*log10(f/1e6) - 9*log10(b);

    % Pérdidas totales.
    if L0 + Lrts + Lmsd < L0
        Lb = L0;
    else
        Lb = L0 + Lrts + Lmsd;
    end
end

end

