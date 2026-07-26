Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FE0355F53;
	Sun, 26 Jul 2026 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098485; cv=none; b=PDEsppLl+ZrRtCz7MlhlsnJYdXG7gkkUnndzmp1D9SLguZ4x1UvPJlzyivTtWn5OVqmX/kwOX+1N6PJeFJcrF42WVZh7H7cjSeslF2W8Qss+jocWOaW42xo2JFTm9FU0g2T1QyDm0hx0RPafAxOkwmZ9+tOaYbIrDars3boLGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098485; c=relaxed/simple;
	bh=S/9uXYuR87xvRihC+6Q+uMs1Sa+/mqujN+9MH28NOzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZWByuUtCYjLvkCTV6mAjSh9na1IgSwxdtAFgK/RHu1oVZ8r4kHCRbgDtk3SHfyNYKBPA/reUm/PywDnqxOCDztqtyTgIopOX+M7cYaUtWfQ6NxGOMCTE+BhLUUmBaz8MBOMftiRk0zs48lOun3sRSp7laVJJer/VCc24aTQx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwAw7hCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwAw7hCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3751A1F000E9;
	Sun, 26 Jul 2026 20:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785098483;
	bh=OgS8x+YxtWW3VM3C8eV4VxTKs6jaXLAxn9D/IY92PQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SwAw7hCVypDAaiEHmxfTtCYQJ2Grenmca009TOXZ8piIcvjtYwqp4X3avnu74Q6yR
	 LOqlAQ6odlId20dVFRE8yx0iCCC6x5K02Oae78rJYbk3N87UjYUcSFk9ktr/nEFTpo
	 +6ZBJ+3tWCGUk9euMCIoLuITT2m8z4Uf6ic48I68sSkaz7eiL60Uyoku2E5mR9Nzfp
	 d65xLArIhWlbeTz2wQ5KskWMGDIrqhu31g4xDeauzzzs0ax1K6w0G3tNuWQlz5LuXL
	 Bd0JIeXGop3+taiyGTsh1meJDMl8wHy2qMnmrM/TenkWzttzpXfa+cRJuxhF8oVAKD
	 nJDC5dUjG3S4A==
Date: Sun, 26 Jul 2026 22:41:20 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Ramiro Oliveira <ramiro.oliveira@advantech.com>
Cc: Lee Jones <lee@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	linux-pm@vger.kernel.org, Wenkai Chung <wenkai.chung@advantech.com.tw>, 
	Francisco Aragon-Trivino <francisco.aragon-trivino@advantech.com>, Hongzhi Wang <hongzhi.wang@advantech.com>, 
	Mikhail Tsukerman <mikhail.tsukerman@advantech.com>, Thomas Kastner <thomas.kastner@advantech.com>
Subject: Re: [PATCH v2 4/8] Add Advantech EIO I2C driver
Message-ID: <amZsX1SEjK0irSRv@zenone.zhora.eu>
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-4-76e5e41026db@advantech.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-upstream-v2-v2-4-76e5e41026db@advantech.com>

Hi Ramiro,

I had a fast look and I'm limiting to few comments this round.

On Tue, Jul 14, 2026 at 05:54:18PM +0200, Ramiro Oliveira wrote:
> This commit adds the driver to control the Advantech EIO I2C block, this
> block is included in the Advantech EIO MFD.

Can you please read the SubmittingPatches documentation for
properly formatting the commit log? Please ask if you have
questions.

...

> +static inline int eio_reg_set_bits(const struct eio_i2c_chan *chan,
> +				   unsigned int reg, unsigned int mask)
> +{
> +	return regmap_update_bits(chan->parent->regmap, reg, mask, mask);
> +}
> +
> +static inline int eio_reg_clear_bits(const struct eio_i2c_chan *chan,
> +				     unsigned int reg, unsigned int mask)
> +{
> +	return regmap_update_bits(chan->parent->regmap, reg, mask, 0);

should the two regmap_update_bits above use chan->base + reg?

> +}

...

> +static int smb_access(struct eio_i2c_chan *i2c_chan, u8 addr, bool is_read, u8 cmd,
> +		      int size, union i2c_smbus_data *data)
> +{
> +	int i, tmp, ret = 0;
> +	unsigned int st1, st2;
> +	int len = 0;

...

> +		for (i = 1; i <= len; i++)
> +			eio_reg_read(i2c_chan, SMB_REG_HBLOCK,
> +				     (unsigned int *)&data->block[i]);

mmmhhhh... how many bytes are you sending to eio_reg_read()
starting from &data_block[i]?

> +		break;

...

> +static int eio_i2c_probe(struct platform_device *pdev)
> +{
> +	static const char * const names[] = { "i2c0", "i2c1", "smb0", "smb1" };
> +	struct device *dev = &pdev->dev;
> +	struct eio_i2c_dev *eio_i2c;
> +	struct eio_dev *eio_dev = dev_get_drvdata(dev->parent);
> +	int ret = 0;
> +	enum eio_chan_id ch;
> +
> +	if (!eio_dev) {
> +		dev_err(dev, "Error contact eio_core\n");

please use dev_err_probe()

Andi

> +		return -ENODEV;
> +	}
