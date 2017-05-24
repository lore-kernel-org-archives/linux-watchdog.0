Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37633 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759620AbdEXIdC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 24 May 2017 04:33:02 -0400
Received: by mail-wm0-f54.google.com with SMTP id d127so58550640wmf.0
        for <linux-watchdog@vger.kernel.org>; Wed, 24 May 2017 01:33:01 -0700 (PDT)
Date: Wed, 24 May 2017 09:32:43 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RESEND PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator
 driver
Message-ID: <20170524083243.5rhritb2tvmycfc6@dell>
References: <cover.1495546845.git.stwiss.opensource@diasemi.com>
 <ac0c9c0edf9a3a48d8de7a5c07b16b771871796e.1495546845.git.stwiss.opensource@diasemi.com>
 <20170523171721.lpqjhakaawnz4prz@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170523171721.lpqjhakaawnz4prz@sirena.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, 23 May 2017, Mark Brown wrote:

> On Tue, May 23, 2017 at 02:40:45PM +0100, Steve Twiss wrote:
>=20
> > This patch was Acked by Mark Brown, a long time ago, way back in Oct =
2016
> > (https://patchwork.kernel.org/patch/9397787/).
> > I have kept Mark Brown's Ack attached because there have been no real
> > code changes since then, but I have recently updated the copyright he=
ader
> > slightly, rebased the code (no changes necessary) and compile tested =
it
> > against x86_64.
>=20
> > The MFD files which this patch depended on were accepted into linux-n=
ext
> > by Lee Jones last week. If there is anything in the way of this patch
> > acceptance, could you please let me know?
>=20
> Given that I've acked this and it depends on the MFD changes I'd have
> expected Lee to apply it.  If nothing else happens I can apply it after
> the next merge window, otherwise either Lee needs to send me a pull
> request for the MFD change so I've got the dependency or he needs to
> apply this.

Plan is to push this through the MFD tree.

Do you want a PR for this one?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
