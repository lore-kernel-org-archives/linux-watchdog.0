Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8F3F5BED
	for <linux-watchdog@vger.kernel.org>; Fri, 24 Jul 2026 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784928705; cv=none; b=WSMdfzrw6eL1GBoj8G8RyKDiqqomkDi9w246ClfYpy1LPWbO3UMyi/nbznw8MvOhW+zwz24mmlZsJlrV80spSbkfswQe2G6Ot6SVb+Qwe1nR6ilMJnC4GIDEdsKx6Z/KikD/WxSyJjgJyUSrGzYJPzZXBQJ+E8WZuohNs2dZTJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784928705; c=relaxed/simple;
	bh=3BXWnD402hSfrfyEk+w77kbuQrHpzt9R/PGME+Cz84g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZXfN/aAtg8fazBkbrWBLymEMy3GAtXbGXKLqXKSWTaWgvCzwazUXVVuoY5G3D0b9719/hFb7+/sPo1tQLDI8zi5qObzZmsKD4xdOPmRF6YKC+9NsFHtpLHhmgm2uP2qrDyIwRUHlE4N4Gw21tg7MoYU8IzbM0M47l7OHJAGUmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCoFx7j2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCoFx7j2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774371F0155B
	for <linux-watchdog@vger.kernel.org>; Fri, 24 Jul 2026 21:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784928703;
	bh=1lyKPNn2+QBheUHLLKeFUz3rZkaxAhPd6rt5QtwoqWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OCoFx7j2pIEMeh9nhRSL8q/TYgVfqJjt4dtbiICKctHvcakmeRD09WLrhX6nKPJu0
	 dVndMg9nCsYBR6MLTXYiH2aATB7R79iQp0JN9vuhmWubEnXHCytzsVrVdCNdffdJmU
	 dpYnFt1ZYDI2GJPyp452rcXEi8stnsMn/HpGFR9LcatN7nAVjuHJa7tztCCtmLXET0
	 hmUCtkuP5lUKHcvJhw1IWPuOnRHoHurSUf354KkaNVSGR39tW7IZtGtDh2UQvuoV+f
	 rFz0D08y4+BuGwd69jzb0XhxjEVtAPJ7NvGUNXzAFkKnqRrRBNTKBtom0VsTmxqLjT
	 esqUfx3aGyY2g==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c8e65e3f5so7812831fa.0
        for <linux-watchdog@vger.kernel.org>; Fri, 24 Jul 2026 14:31:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpRnFTi359rhLZuvYuBD9WTEXNK6i1A6z4QiUODqFhbXnvwDiE/eISZa6xE4R1LLVVbqtll81m6NM1i75fgrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHV9xnKaYy6pP/Rp1EFY3gF2o9TPRG/U0qjHnHZeW8G0xFKwku
	vL3L6Orysl0LRVpoFOZrrG1dM4Hdg601LdssnDZwdc9v3mEChGEUHQH3YVVTXpMQTtWrujg8r7m
	oL75oneR1a7K3RHDzC9oif0Ej8QQqJfI=
X-Received: by 2002:a05:6512:368e:b0:5ae:b584:562b with SMTP id
 2adb3069b0e04-5b2b2f76626mr1381067e87.48.1784928701837; Fri, 24 Jul 2026
 14:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com> <20260714-upstream-v2-v2-2-76e5e41026db@advantech.com>
In-Reply-To: <20260714-upstream-v2-v2-2-76e5e41026db@advantech.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 24 Jul 2026 23:31:29 +0200
X-Gmail-Original-Message-ID: <CAD++jLn9VMq5RcGQy-1TB=SdgkynSDbjeeKoNQ7Z4ZArw-AGFw@mail.gmail.com>
X-Gm-Features: AUfX_mx-62JQQDBcTKutXOrN-Q2fNr59laJWx5ddo44mrkoC0a-8lhzFzZvvk98
Message-ID: <CAD++jLn9VMq5RcGQy-1TB=SdgkynSDbjeeKoNQ7Z4ZArw-AGFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] Add Advantech EIO GPIO driver
To: Ramiro Oliveira <ramiro.oliveira@advantech.com>
Cc: Lee Jones <lee@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Andi Shyti <andi.shyti@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	linux-pm@vger.kernel.org, Wenkai Chung <wenkai.chung@advantech.com.tw>, 
	Francisco Aragon-Trivino <francisco.aragon-trivino@advantech.com>, 
	Hongzhi Wang <hongzhi.wang@advantech.com>, 
	Mikhail Tsukerman <mikhail.tsukerman@advantech.com>, 
	Thomas Kastner <thomas.kastner@advantech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ramiro,

thanks for your patch!

On Tue, Jul 14, 2026 at 5:54=E2=80=AFPM Ramiro Oliveira
<ramiro.oliveira@advantech.com> wrote:


> +static int get_dir(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u8 dir;
> +       int ret;
> +
> +       ret =3D pmc_read(chip->parent, EIO_GPIO_PIN_DIR, offset, &dir);
> +       if (ret)
> +               return ret;
> +
> +       return dir ? 0 : 1;

Please use:
return dir ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;

> +static int dir_input(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u8 dir =3D 0;

Use some local define for this stuff like:

#define EIO_GPIO_DIR_IN 0
#define EIO_GPIO_DIR_OUT 1

> +static int dir_output(struct gpio_chip *chip, unsigned int offset, int v=
alue)
> +{
> +       u8 dir =3D 1;

Also here.

> +       u8 val =3D value;
> +
> +       pmc_write(chip->parent, EIO_GPIO_PIN_DIR, offset, &dir);
> +
> +       return pmc_write(chip->parent, EIO_GPIO_PIN_LEVEL, offset, &val);
> +}
> +
> +static int gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u8 level;
> +       int ret;
> +
> +       ret =3D pmc_read(chip->parent, EIO_GPIO_PIN_LEVEL, offset, &level=
);
> +       if (ret)
> +               return ret;
> +
> +       return level;

return !!level;

so you clamp this to [0, 1]

> +static int check_support(struct device *dev)

Check support for what? Spell it out.

> +{
> +       u8  data;
> +       int ret;
> +
> +       ret =3D pmc_read(dev, EIO_GPIO_STATUS, 0, &data);
> +       if (ret)
> +               return ret;
> +
> +       if ((data & 0x01) =3D=3D 0)
> +               return -EOPNOTSUPP;

Use:

#define EIO_GPIO_HAS_SUPPORT_FOR_X BIT(0)

if (!(data & EIO_GPIO_HAS_SUPPORT_FOR_X))
        return -EOPNOTSUPP;

> +static int check_pin(struct device *dev, int pin)
> +{
> +       int ret;
> +       int group, bit;
> +       u16 data;
> +
> +       /* Get pin mapping */
> +       ret =3D pmc_read(dev, EIO_GPIO_MAPPING, pin, &data);
> +       if (ret)
> +               return ret;
> +
> +       if ((data & 0xFF) > ARRAY_SIZE(group_map))
> +               return -EINVAL;
> +
> +       group =3D group_map[data & 0xFF].group;
> +       bit   =3D data >> 8;
> +
> +       /* Check mapped pin */
> +       ret =3D pmc_read(dev, EIO_GPIO_GROUP_AVAIL, group, &data);
> +       if (ret)
> +               return ret;
> +
> +       return data & BIT(bit) ? 0 : -EOPNOTSUPP;
> +}

So there is some pin muxing going on here. If that should be made dynamic
at some point this should make use of the pin control subsystem, but I gues=
s
it is currently hard-coded?

Yours,
Linus Walleij
