Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35134 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdE3JSJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 May 2017 05:18:09 -0400
Received: by mail-wm0-f42.google.com with SMTP id b84so83828889wmh.0
        for <linux-watchdog@vger.kernel.org>; Tue, 30 May 2017 02:18:03 -0700 (PDT)
Date: Tue, 30 May 2017 10:17:59 +0100
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
Message-ID: <20170530091759.tkajnmlyel6h3djw@dell>
References: <cover.1495546845.git.stwiss.opensource@diasemi.com>
 <ac0c9c0edf9a3a48d8de7a5c07b16b771871796e.1495546845.git.stwiss.opensource@diasemi.com>
 <20170523171721.lpqjhakaawnz4prz@sirena.org.uk>
 <20170524083243.5rhritb2tvmycfc6@dell>
 <20170524101057.v2fqwki4fopx5k7y@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170524101057.v2fqwki4fopx5k7y@sirena.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, 24 May 2017, Mark Brown wrote:

> On Wed, May 24, 2017 at 09:32:43AM +0100, Lee Jones wrote:
>=20
> > Plan is to push this through the MFD tree.
>=20
> Great, thanks.

Just taking a look at this now.  It looks like the dependency:

  656211b1dfb9 mfd: Add support for DA9061

... is now in Mainline.  Therefore it should be okay to take this
directly through the Regulator repo.

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
