Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:21642 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753906AbaF3Jpf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Jun 2014 05:45:35 -0400
Date: Mon, 30 Jun 2014 11:47:01 +0200
From: Jean-Francois Moine <moinejf@free.fr>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-ide@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	alsa-devel@alsa-project.org, Bryan Wu <cooloney@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	rtc-linux@googlegroups.com, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Tejun Heo <tj@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Mark Brown <broonie@kernel.org>,
	Richard Purdie <rpurdie@rpsys.net>, linux-pci@vger.kernel.org,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-leds@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 00/13] Remove mach-kirkwood and mach-dove
Message-ID: <20140630114701.1368d49e@armhf>
In-Reply-To: <20140630084918.GS32514@n2100.arm.linux.org.uk>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
	<20140629213510.GR32514@n2100.arm.linux.org.uk>
	<20140630091643.2df3b0fb@armhf>
	<20140630084918.GS32514@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 30 Jun 2014 09:49:18 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> The problem is that the picture appears for about a second, then goes=
 black
> for maybe a couple of seconds, then reappears for about a second and =
this
> cycle repeats.  Rebooting into the DT kernel doesn't fix it.  Rebooti=
ng
> back into the non-DT kernel does fix it.  Then if you boot back into =
the DT
> kernel it's back again.  Boot back into the non-DT kernel and it's ag=
ain
> fixed.
>=20
> I have compared register settings for the Si5351, LCD controllers and=
 the
> TDA998x between the non-DT and DT versions, and can find no differenc=
es
> there.  Yet, DT kernels are the only kernels which exhibit this behav=
iour.
> Non-DT kernels (which I've run continuously including many reboots) f=
or
> the last two years have *never* shown this problem.
>=20
> I have also verified that the HDMI clock is correct.  The problem occ=
urs
> at both 1080p and 720p resolutions (which are the two that are used d=
uring
> boot - I have the kernel using 720p, and Xorg uses 1080p.)
>=20
> I should also point out that in both cases, it is the _same_ kernel b=
inary
> (3.15) that I'm running - the DT test case just has the DT blob attac=
hed
> whereas the non-DT case boots without (and therefore falls back to th=
e
> old platform stuff.)

Have you declared the LCD clock in dove.dtsi?

 	lcdclk: fixed-clock {
		compatible =3D "fixed-clock";
 		#clock-cells =3D <0>;
 		clock-frequency =3D <400000000>;
 	};

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
