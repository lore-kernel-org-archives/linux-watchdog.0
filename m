Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59174 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751671AbaF3WWq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Jun 2014 18:22:46 -0400
Date: Mon, 30 Jun 2014 19:21:45 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, Bryan Wu <cooloney@gmail.com>,
	Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 00/13] Remove mach-kirkwood and mach-dove
Message-ID: <20140630222145.GA8789@arch.cereza>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
 <20140629213510.GR32514@n2100.arm.linux.org.uk>
 <53B154FE.80804@gmail.com>
 <20140630124320.GZ32514@n2100.arm.linux.org.uk>
 <53B164B2.7090902@gmail.com>
 <20140630142516.GA32514@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140630142516.GA32514@n2100.arm.linux.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 30 Jun 03:25 PM, Russell King - ARM Linux wrote:
[..]
>=20
> Right, so what I have against mainline right now in my tree is:
>=20
> * two SPI patches, which have been taken by Mark
> * one long term core ARM patch adding optimised memset/memcpy IO oper=
ations
> * the PMU stuff
> * BMM (already published in git form)
> * Vmeta (already published in git form)
> * ASoC cleanup patches, which Mark took last week.
>=20
> What isn't visible is the stuff which converts Armada DRM to componen=
t
> support, along with the TDA998x driver (and it sounds like the TI LCD=
C
> people may end up blocking that effort).  This is necessary to conver=
t
> it to DT support.  However, this depends on the component helper, and
> that's where there's a blocking problem.
>=20
> I sent out a bunch of patches last week, with a request for help from
> the Exynos people.  So far, that has only attracted one relatively mi=
nor
> comment from the iMX people.  I can't move forwards with the Armada
> DRM until this is sorted.  Neither can I move forward with the TDA998=
x
> driver.
>=20

I'm not sure I understand why tilcdc people are an obstacle for the
component stuff, other than the lack of responsiveness. In any case, if
you have some tilcdc or tda998x patches and you need help with the main=
line
process, feel free to ask.

I've been doing some tilcdc work lately, and I'd be happy to help you w=
ith
that.

Do you plan to change the devicetree binding? While the current one wor=
ks fine,
it has several deficiencies, and it would be great to sort them out bef=
ore
the whole platform becomes obsolete.

Really, if you need help and if you think I can handle it, just drop me=
 a line
and I'll see what I can do.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
