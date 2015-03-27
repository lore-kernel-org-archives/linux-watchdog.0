Return-path: <omaplinuxkernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <148dd2d6912211bc468c30acf85a463192576039.1427356791.git.baruch@tkos.co.il>
References: <a4554d0a61c62b85a7d66b6e3d16d07f8a498025.1427356791.git.baruch@tkos.co.il>
	<148dd2d6912211bc468c30acf85a463192576039.1427356791.git.baruch@tkos.co.il>
Date: Fri, 27 Mar 2015 11:10:32 +0530
Message-ID: <CAM=Q2ctS6_=pzW2H+Yd3nEBgF269vfdh8yV3NbnWFP7b-MWLbA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] watchdog: digicolor: driver for Conexant Digicolor
 CX92755 SoC
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/alternative; boundary=089e0122aa561d41c905123e925d
List-ID: <linux-watchdog@vger.kernel.org>

--089e0122aa561d41c905123e925d
Content-Type: text/plain; charset=UTF-8

>
>
> +
> +static int dc_restart_handler(struct notifier_block *this, unsigned long
> mode,
> +                             void *cmd)
> +{
> +       struct dc_wdt *wdt = container_of(this, struct dc_wdt,
> restart_handler);
> +
> +       dc_wdt_set(wdt, 1);
> +       /* wait for reset to assert... */
> +       mdelay(500);
>

How is the 500 calculated ?
Also is it possible to sleep here?


> +
> +       return NOTIFY_DONE;
> +}
> +
> +static int dc_wdt_start(struct watchdog_device *wdog)
> +{
> +       struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
> +
> +       dc_wdt_set(wdt, wdog->timeout * clk_get_rate(wdt->clk));
> +
> +       return 0;
> +}
> +
>
>

--089e0122aa561d41c905123e925d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"><br>
+<br>
+static int dc_restart_handler(struct notifier_block *this, unsigned long m=
ode,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dc_wdt *wdt =3D container_of(this, struc=
t dc_wdt, restart_handler);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dc_wdt_set(wdt, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* wait for reset to assert... */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mdelay(500);<br>
</blockquote><div><br></div><div>How is the 500 calculated ?</div><div>Also=
 is it possible to sleep here?</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return NOTIFY_DONE;<br>
+}<br>
+<br>
+static int dc_wdt_start(struct watchdog_device *wdog)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dc_wdt *wdt =3D watchdog_get_drvdata(wdo=
g);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dc_wdt_set(wdt, wdog-&gt;timeout * clk_get_rate=
(wdt-&gt;clk));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br><span class=3D"HOEnZb"><font color=3D"#888888"><br>
</font></span></blockquote></div><br></div></div>

--089e0122aa561d41c905123e925d--
