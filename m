Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33513 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754612AbdC1IWT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Mar 2017 04:22:19 -0400
Received: by mail-wr0-f174.google.com with SMTP id w43so78958683wrb.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Mar 2017 01:22:13 -0700 (PDT)
Date: Tue, 28 Mar 2017 09:21:41 +0100
From: Lee Jones <lee.jones@linaro.org>
To: kbuild test robot <lkp@intel.com>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>, kbuild-all@01.org,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V6 4/7] mfd: da9061: MFD core support
Message-ID: <20170328082141.u2rgnhei5yhhzxdn@dell>
References: <539b8756120ab3558c906f7457e65f94dbe37425.1490608293.git.stwiss.opensource@diasemi.com>
 <201703272258.hWlipe1g%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201703272258.hWlipe1g%fengguang.wu@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Mar 2017, kbuild test robot wrote:

> Hi Steve,
>=20
> [auto build test WARNING on ljones-mfd/for-mfd-next]
> [also build test WARNING on v4.11-rc4 next-20170327]
> [if your patch is applied to the wrong git tree, please drop us a note =
to help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Steve-Twiss/Documentat=
ion-devicetree-watchdog-da9062-61-watchdog-timer-binding/20170327-215359
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for=
-mfd-next
> config: x86_64-randconfig-x009-201713 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64=20
>=20
> All warnings (new ones prefixed by >>):
>=20
>    drivers//mfd/da9062-core.c: In function 'da9062_i2c_probe':
> >> drivers//mfd/da9062-core.c:845:21: warning: cast from pointer to int=
eger of different size [-Wpointer-to-int-cast]
>       chip->chip_type =3D (int)match->data;
>                         ^

Please use longs or enums.

> vim +845 drivers//mfd/da9062-core.c
>=20
>    829		unsigned int irq_base;
>    830		const struct mfd_cell *cell;
>    831		const struct regmap_irq_chip *irq_chip;
>    832		const struct regmap_config *config;
>    833		int cell_num;
>    834		int ret;
>    835=09
>    836		chip =3D devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
>    837		if (!chip)
>    838			return -ENOMEM;
>    839=09
>    840		if (i2c->dev.of_node) {
>    841			match =3D of_match_node(da9062_dt_ids, i2c->dev.of_node);
>    842			if (!match)
>    843				return -EINVAL;
>    844=09
>  > 845			chip->chip_type =3D (int)match->data;
>    846		} else {
>    847			chip->chip_type =3D id->driver_data;
>    848		}
>    849=09
>    850		i2c_set_clientdata(i2c, chip);
>    851		chip->dev =3D &i2c->dev;
>    852=09
>    853		if (!i2c->irq) {
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology =
Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpo=
ration



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
