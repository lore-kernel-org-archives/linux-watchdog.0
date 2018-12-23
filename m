Return-Path: <pburton@wavecomp.com>
Return-path: <pburton@wavecomp.com>
From: Paul Burton <paul.burton@mips.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
	<linux@roeck-us.net>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James
 Hogan <jhogan@kernel.org>, "linux-mips@linux-mips.org"
	<linux-mips@linux-mips.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v4] watchdog: mtx-1: Convert to use GPIO descriptor
Date: Sun, 23 Dec 2018 15:26:33 +0000
Message-ID: <20181223152625.bbaa6o3gc6q2r7qo@pburton-laptop>
References: <20181222101231.19092-1-linus.walleij@linaro.org>
In-Reply-To: <20181222101231.19092-1-linus.walleij@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <320562F142CED54A9FBE79D0F44B40ED@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

On Sat, Dec 22, 2018 at 11:12:31AM +0100, Linus Walleij wrote:
> This converts the MTX-1 driver to grab a GPIO descriptor
> associated with the device instead of using a resource with
> a global GPIO number. Augment the driver and the boardfile.
>=20
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@linux-mips.org
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Collect Florian's Review-tag.
> - Cc MIPS maintainers. Please provide an ACK so that Guenther
>   can merge this into the watchdog tree!

Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
