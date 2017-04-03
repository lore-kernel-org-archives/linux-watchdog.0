Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34892 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753275AbdDCNj1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Apr 2017 09:39:27 -0400
Received: by mail-wm0-f49.google.com with SMTP id y22so25972839wmh.0
        for <linux-watchdog@vger.kernel.org>; Mon, 03 Apr 2017 06:39:26 -0700 (PDT)
Date: Mon, 3 Apr 2017 14:39:22 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V7 3/7] Documentation: devicetree: mfd: da9062/61 MFD
 binding
Message-ID: <20170403133922.iikcgoboisn7qg2e@dell>
References: <cover.1490712213.git.stwiss.opensource@diasemi.com>
 <1c12168d005cec5be6cab78f99c4dce95caa128b.1490712213.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c12168d005cec5be6cab78f99c4dce95caa128b.1490712213.git.stwiss.opensource@diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Mar 2017, Steve Twiss wrote:

> From: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> Extend existing DA9062 binding information to include the DA9061 PMIC f=
or
> MFD core and regulators.
>=20
> Add a da9062-onkey link to the existing onkey binding file.
>=20
> Add a da9062-thermal link to the new temperature monitoring binding fil=
e.
>=20
> Delete the da9062-watchdog section and replace it with a link to the ne=
w
> DA9061/62 binding information file.
>=20
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> This patch applies against linux-next and v4.11-rc3
>=20
> v6 -> v7
>  - NO CODE CHANGE
>=20
> v5 -> v6
>  - NO CODE CHANGE
>  - Rebased from v4.9 to v4.11-rc3
>=20
> v4 -> v5
>  - NO CODE CHANGE
>  - Rebased from v4.8 to v4.9
>=20
> v3 -> v4
>  - Patch renamed from [PATCH V3 4/9] to [PATCH V4 3/8]
>  - Remove double newline spacing in text file
>  - Added Acked-by Rob Herring
>=20
> v2 -> v3
>  - Patch renamed from [PATCH V2 04/10] to [PATCH V3 4/9]
>  - Ensure binding description concentrates on the device not the
>    device driver
>  - Separate the DA9061 and DA9062 sub-device tables to distinguish
>    the difference between the two devices
>  - Update the commit message to describe this change
>  - Add e-mail information about associated patches from this set
>    without describing them as being explicitly dependent on this
>    binding
>=20
> v1 -> v2
>  - Patch renamed from [PATCH V1 09/10] to [PATCH V2 04/10] -- these
>    changes were made to fix checkpatch warnings caused by the patch
>    set dependency order
>=20
> Hi,
>=20
> Added an Ack from Rob Herring for the PATCH V3 version.
>=20
> As previously:
> Other information:
> The device driver from this patch set (associated with this binding) is
>=20
> - [PATCH V5 4/8] mfd: da9061: MFD core support
>=20
> and also the following binding file changes:
>=20
> - Binding for onkey (already applied by Dmitry Torokhov)
> - [PATCH V5 1/8] Binding for watchdog
> - [PATCH V5 2/8] Binding for thermal
>=20
> Regards,
> Steve Twiss, Dialog Semiconductor
>=20
>=20
>  Documentation/devicetree/bindings/mfd/da9062.txt | 49 ++++++++++++++++=
+-------
>  1 file changed, 36 insertions(+), 13 deletions(-)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documen=
tation/devicetree/bindings/mfd/da9062.txt
> index 38802b5..c0a418c 100644
> --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> @@ -1,22 +1,39 @@
>  * Dialog DA9062 Power Management Integrated Circuit (PMIC)
> =20
> -DA9062 consists of a large and varied group of sub-devices:
> +Product information for the DA9062 and DA9061 devices can be found her=
e:
> +- http://www.dialog-semiconductor.com/products/da9062
> +- http://www.dialog-semiconductor.com/products/da9061
> +
> +The DA9062 PMIC consists of:
> =20
>  Device                   Supply Names    Description
>  ------                   ------------    -----------
>  da9062-regulator        :               : LDOs & BUCKs
>  da9062-rtc              :               : Real-Time Clock
> +da9062-onkey            :               : On Key
> +da9062-watchdog         :               : Watchdog Timer
> +da9062-thermal          :               : Thermal
> +
> +The DA9061 PMIC consists of:
> +
> +Device                   Supply Names    Description
> +------                   ------------    -----------
> +da9062-regulator        :               : LDOs & BUCKs
> +da9062-onkey            :               : On Key
>  da9062-watchdog         :               : Watchdog Timer
> +da9062-thermal          :               : Thermal
> =20
>  =3D=3D=3D=3D=3D=3D
> =20
>  Required properties:
> =20
> -- compatible : Should be "dlg,da9062".
> +- compatible : Should be
> +    "dlg,da9062" for DA9062
> +    "dlg,da9061" for DA9061
>  - reg : Specifies the I2C slave address (this defaults to 0x58 but it =
can be
>    modified to match the chip's OTP settings).
>  - interrupt-parent : Specifies the reference to the interrupt controll=
er for
> -  the DA9062.
> +  the DA9062 or DA9061.
>  - interrupts : IRQ line information.
>  - interrupt-controller
> =20
> @@ -25,8 +42,8 @@ further information on IRQ bindings.
> =20
>  Sub-nodes:
> =20
> -- regulators : This node defines the settings for the LDOs and BUCKs. =
The
> -  DA9062 regulators are bound using their names listed below:
> +- regulators : This node defines the settings for the LDOs and BUCKs.
> +  The DA9062 regulators are bound using their names listed below:
> =20
>      buck1    : BUCK_1
>      buck2    : BUCK_2
> @@ -37,19 +54,29 @@ Sub-nodes:
>      ldo3     : LDO_3
>      ldo4     : LDO_4
> =20
> +  The DA9061 regulators are bound using their names listed below:
> +
> +    buck1    : BUCK_1
> +    buck2    : BUCK_2
> +    buck3    : BUCK_3
> +    ldo1     : LDO_1
> +    ldo2     : LDO_2
> +    ldo3     : LDO_3
> +    ldo4     : LDO_4
> +
>    The component follows the standard regulator framework and the bindi=
ngs
>    details of individual regulator device can be found in:
>    Documentation/devicetree/bindings/regulator/regulator.txt
> =20
> -
>  - rtc : This node defines settings required for the Real-Time Clock as=
sociated
>    with the DA9062. There are currently no entries in this binding, how=
ever
>    compatible =3D "dlg,da9062-rtc" should be added if a node is created=
.
> =20
> -- watchdog: This node defines the settings for the watchdog driver ass=
ociated
> -  with the DA9062 PMIC. The compatible =3D "dlg,da9062-watchdog" shoul=
d be added
> -  if a node is created.
> +- onkey : See ../input/da9062-onkey.txt
> +
> +- watchdog: See ../watchdog/da9062-watchdog.txt
> =20
> +- thermal : See ../thermal/da9062-thermal.txt
> =20
>  Example:
> =20
> @@ -64,10 +91,6 @@ Example:
>  			compatible =3D "dlg,da9062-rtc";
>  		};
> =20
> -		watchdog {
> -			compatible =3D "dlg,da9062-watchdog";
> -		};
> -
>  		regulators {
>  			DA9062_BUCK1: buck1 {
>  				regulator-name =3D "BUCK1";

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
