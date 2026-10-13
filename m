Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3866113B58C;
	Tue, 13 Oct 2026 04:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791864272; cv=none; b=ua8KcehkKMpkpMOwslfydmal0antTyCSraiopoKf+YEvhC6lEsC22niNg928DeLAJu1xNsKiGrTAG0gIYweaExbH8oYEwuPa1D1z/FJdEtGqlLGjBsz9AU6NIL10657l8JJjWDTVkG3Fbzi1tbYQ2bNTkJ9232KwsqAXyQBfaBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791864272; c=relaxed/simple;
	bh=lJseiDDUZ465xiIceKDH//TXGmUtXfHH0DmltCq3UsA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=af6QLDOLJ69e0f6vmX245N+kbD8jDf6NHxQGkpsV72hQxRF0x8DbaFMTvjb5ZPN/v0vdSKwyx/YtwoJKJmLGnCIn7GSOJbeNiydUswtj3uSnqX/8PCnrXu+eJVCNJVP6x3svVsQ7FU9mnNwCSP03rXBDCZC+9tj0cbBQZT6AmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4I11zyc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4I11zyc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2901F000FF;
	Tue, 13 Oct 2026 04:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791864270;
	bh=4FlSH+FXgl/o6GZ48/QU4F6k9XKuw39vFKXm9gSTPj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X4I11zycjVHKuWjtBx2annmtr4zdP3hnk4emsy26sHB88CDEKjqDdCo4q2Njk0xeR
	 N00qpsZv0O5gETSqKuOg4As1fAqW7eD07CAOSgq1icrAqLFPQG0LCWo8w4i3SyNfoA
	 5J0nAZrrMZfgPYo+N+1KXRDfAFsp3BTxiKvRSfE77SXqhEjM/sgeuqo3wVFb5rtC0v
	 5SWO61ofXIcEi+f5gggVfF8m+6itACifKs/yyU2cIjjOex3BR9EBdSaJJSfPLWXwLf
	 Ah9BTHVIhU2y7gIfhUha5D4wxzkz6UIq41pszs6K8cK9ERCMvkCGKKqd84CfOaXTHo
	 rYUcHOhksrB5w==
Message-ID: <sashiko-outbox-168954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] i2c: Add Cortina Systems CS75xx I2C controller
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261013-b4-cs75xx-s2-v2-6-94f8c0a90cda@gmail.com>
References: <20261013-b4-cs75xx-s2-v2-0-94f8c0a90cda@gmail.com>
 <20261013-b4-cs75xx-s2-v2-6-94f8c0a90cda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 04:04:29 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] i2c: lockless hardware reset races with ISR after transfer timeout
- [Medium] i2c: integer overflow in CS75xx clock prescaler boundary check
- [Medium] i2c: cs75xx: premature controller reset on multi-master bus due =
to 1ms timeout
--

commit ab11b4fa940bf862049e3ce494994f7702146e7c
Author: Fil Dunsky <filipp.dunsky@gmail.com>

i2c: Add Cortina Systems CS75xx I2C controller driver

This commit adds a new I2C controller driver for the Cortina Systems CS75xx
SoCs. It supports single-byte transfers with a command register, handles
interrupts upon command completion, and supports arbitration loss retries.

> diff --git a/drivers/i2c/busses/i2c-cs75xx.c b/drivers/i2c/busses/i2c-cs7=
5xx.c
> new file mode 100644
> index 0000000000000..3eca5fb14266e
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-cs75xx.c
[ ... ]
> +static irqreturn_t cs75xx_i2c_isr(int irq, void *dev_id)
> +{
> +	struct cs75xx_i2c *i2c =3D dev_id;
> +	u32 ctrl, ack;
> +
> +	guard(spinlock)(&i2c->lock);
> +
> +	if (!(readl(i2c->base + CS75XX_I2C_INT) & CS75XX_I2C_INT_DONE))
> +		return IRQ_NONE;
> +
> +	writel(CS75XX_I2C_INT_DONE, i2c->base + CS75XX_I2C_INT);
> +
> +	/* The done flag is cleared by writing it back */
> +	ctrl =3D readl(i2c->base + CS75XX_I2C_CTRL);
> +	writel(ctrl, i2c->base + CS75XX_I2C_CTRL);
> +
> +	ack =3D readl(i2c->base + CS75XX_I2C_ACK);
> +	cs75xx_i2c_process(i2c, ack);
> +
> +	return IRQ_HANDLED;
> +}
[ ... ]
> +static int cs75xx_i2c_xfer_msg(struct cs75xx_i2c *i2c, struct i2c_msg *m=
sg,
> +			       bool last)
> +{
> +	unsigned long time_left;
> +
> +	spin_lock_irq(&i2c->lock);
> +	reinit_completion(&i2c->done);
> +	i2c->msg =3D msg;
> +	i2c->pos =3D 0;
> +	i2c->last =3D last;
> +	i2c->err =3D 0;
> +	i2c->state =3D CS75XX_I2C_ADDR;
> +	writel(i2c_8bit_addr_from_msg(msg), i2c->base + CS75XX_I2C_TXR);
> +	writel(CS75XX_I2C_CTRL_START | CS75XX_I2C_CTRL_WRITE,
> +	       i2c->base + CS75XX_I2C_CTRL);
> +	spin_unlock_irq(&i2c->lock);
> +
> +	time_left =3D wait_for_completion_timeout(&i2c->done, i2c->adap.timeout=
);
> +	if (!time_left) {
> +		spin_lock_irq(&i2c->lock);
> +		i2c->state =3D CS75XX_I2C_IDLE;
> +		spin_unlock_irq(&i2c->lock);
> +		dev_err(i2c->dev, "transfer timed out, resetting the controller\n");
> +		cs75xx_i2c_reset(i2c);

[Severity: High]
Is there a race condition between this hardware reset and the interrupt
handler?

When a transfer times out, the lock is dropped before resetting the control=
ler:

CPU1 (Timeout path)
cs75xx_i2c_xfer_msg()
   spin_unlock_irq(&i2c->lock);
   cs75xx_i2c_reset(i2c);
      cs75xx_i2c_hw_init(i2c);
         writel(0, i2c->base + CS75XX_I2C_CFG);  /* Disables the IP */
         usleep_range(5000, 10000);

If a delayed interrupt fires during this sleep window, the ISR will run:

CPU2 (ISR)
cs75xx_i2c_isr()
   guard(spinlock)(&i2c->lock);
   ...
   writel(CS75XX_I2C_INT_DONE, i2c->base + CS75XX_I2C_INT);
   ctrl =3D readl(i2c->base + CS75XX_I2C_CTRL);
   writel(ctrl, i2c->base + CS75XX_I2C_CTRL);

The ISR grabs the lock and performs multiple MMIO reads and writes before it
checks i2c->state. Can accessing these hardware registers while the block is
disabled or in reset trigger an asynchronous external bus abort or panic?

> +		return -ETIMEDOUT;
> +	}
> +
> +	return i2c->err;
> +}
> +
> +static int cs75xx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msg=
s,
> +			   int num)
> +{
> +	struct cs75xx_i2c *i2c =3D i2c_get_adapdata(adap);
> +	u32 val;
> +	int i, ret;
> +
> +	if (readl_poll_timeout(i2c->base + CS75XX_I2C_ACK, val,
> +			       !(val & CS75XX_I2C_ACK_BUSY), 10, 1000)) {
> +		cs75xx_i2c_reset(i2c);

[Severity: Medium]
Is a 1ms (1000 us) timeout sufficient to wait for the I2C bus to become idle
when an external master is executing a legitimate transaction?

If another master initiates a transaction that takes longer than 1ms (such =
as
a transfer larger than 11 bytes at 100 kHz), this poll will time out.

This would cause the driver to prematurely perform a hardware reset and fail
the transfer with -EBUSY, potentially disrupting valid multi-master bus
activity.

> +		if (readl(i2c->base + CS75XX_I2C_ACK) & CS75XX_I2C_ACK_BUSY)
> +			return -EBUSY;
> +	}
[ ... ]
> +static int cs75xx_i2c_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	i2c->ref_rate =3D clk_get_rate(clk);
> +	if (device_property_read_u32(dev, "clock-frequency", &i2c->bus_rate))
> +		i2c->bus_rate =3D I2C_MAX_STANDARD_MODE_FREQ;
> +	if (!i2c->ref_rate || !i2c->bus_rate ||
> +	    i2c->bus_rate > I2C_MAX_FAST_MODE_FREQ ||
> +	    i2c->ref_rate / (5 * i2c->bus_rate) > FIELD_MAX(CS75XX_I2C_CFG_PRER=
) + 1)

[Severity: Medium]
Could this integer division allow boundary values that overflow the 16-bit
prescaler field?

Since FIELD_MAX(CS75XX_I2C_CFG_PRER) is 65535, this check permits the integ=
er
division to evaluate to 65536.

However, cs75xx_i2c_hw_init() calculates the actual prescaler using
DIV_ROUND_UP(i2c->ref_rate, 5 * i2c->bus_rate) - 1.

If the division yields 65536 with any non-zero remainder, DIV_ROUND_UP
evaluates to 65537, causing the calculated prescaler to equal 65536 (0x1000=
0).

When this 17-bit value is passed to FIELD_PREP() in cs75xx_i2c_hw_init(), it
gets silently truncated to 0, which would misconfigure the hardware for the
highest possible bus frequency.

Should this boundary check use DIV_ROUND_UP to match the initialization log=
ic?

> +		return dev_err_probe(dev, -EINVAL,
> +				     "unsupported bus frequency %u Hz\n",
> +				     i2c->bus_rate);
> +
> +	cs75xx_i2c_hw_init(i2c);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
s2-v2-0-94f8c0a90cda@gmail.com?part=3D6
