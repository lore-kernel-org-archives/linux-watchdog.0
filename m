Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37132 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbbEGTN3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 15:13:29 -0400
Received: by widdi4 with SMTP id di4so3052094wid.0
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 12:13:28 -0700 (PDT)
Date: Thu, 7 May 2015 20:13:24 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH 02/12] clocksource: sti: Provide support
 for the ST LPC Clocksource IP
Message-ID: <20150507191324.GB16220@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
 <20150507150440.GA13336@griffinp-ThinkPad-X1-Carbon-2nd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20150507150440.GA13336@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > This IP is shared with Watchdog and RTC functionality.  Only one of
> > these IPs can be used at the same time.  We use the device-driver
> > model combined with a DT 'mode' property to enforce this.
>=20
> Which means my previous assertion in V1 that the IP didn't exist on s=
tih415/6
> SoC is most likely wrong, as the watchdog driver has bindings already=
 for those
> platforms.
>=20
> I did try this before and couldn't get it working (driver failed on c=
lk_get_rate)
> on stih416-b2020.
>=20
> Did you try and see if you can get this also working for stih415/6 So=
Cs? It would
> mean we can move away from arm_global_timer for all upstreamed STI pl=
atforms.

This patch-set only supports STiH4{07,10}, which is the only platform
it's been tested on until this point.  I can investigate porting it to
Orly/Orly2 as a subsequent piece of work if it's going to be useful
for ST.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
