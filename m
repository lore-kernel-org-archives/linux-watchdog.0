Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A034388F;
	Mon, 12 Oct 2026 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827187; cv=none; b=qdUIuwcYcNDIbDmbTaWr+lIC84eOopr7DH21KjTFNKOsH0w5d9HnZhk+HFW6KU+KcCFaTwMdlVhOrOBO5LkNakyFzb4HsAqTdpZXUzZGwzp1aimLXd9LFGEZLo849fTptRgadxdwAIzpSMc319KrymbXuZhAcRR8sPtWP6/t+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827187; c=relaxed/simple;
	bh=jrN1RemX+8+uqo2me2BEKWlDYuExUjFkMNEklYa5e40=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hQWPaWqEdtDFGm6S0qfjP6ulNU8C34v+F+oytjXmVN2FFWYMFnqtwzQ3KdVUpVq0R+hIdl4Fl+4CoZfhfNEcl6Djh5lpQVjhQm4CmpXy2w8MmzP2iE7l2lu9S6jc9mv8jD8MhR6IBlvtSw29o4O4+rTby+uzMp9cwx/UBXgQikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKENnRa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKENnRa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6671F008A1;
	Mon, 12 Oct 2026 17:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791827186;
	bh=IRuRmJvzKxIb799RocDcW4Ik8w8yn37nxCQpCnAJshg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HKENnRa8yxWRcfONi/JF/ZZuXV8tGguuzrb3poOLgxgb1Hz7G2GWGFKv7JmsJqSEv
	 yF8hPaxHLXQ4UZiBYQYyBGYkvUPjgSAKGHmCfMiw92o2K3IlsdbjRpDlMvlEl/LYUH
	 GU9OZXu6doTSPkPThlhXesQuAoRaqsba1NCwEprIdpzgMeFZeNIK8SUdW/tgp1lOsz
	 /llvoe8/e56RxoyMb7YYZSSx6/1S0K/6SdlRaP4nJL7RtPZI/myfTCkImTrg9l9/xU
	 Z6weoY5Bfh/CCoUtFUAOgS62zUZwKlVY7RcwFb747uxz6hjRPEb1rOvppj2FyLA2pQ
	 HonYeJR2zU5bQ==
Message-ID: <sashiko-outbox-168487@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] i2c: Add Cortina Systems CS75xx I2C controller
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: robh@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261012-b4-cs75xx-s2-v1-6-8a7641b7b79c@gmail.com>
References: <20261012-b4-cs75xx-s2-v1-0-8a7641b7b79c@gmail.com>
 <20261012-b4-cs75xx-s2-v1-6-8a7641b7b79c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:46:25 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] i2c: ignored NACK on final byte of write transfer
- [High] i2c: hardware busy timeout ignored
- [High] i2c: cs75xx: race between STOP completion IRQ and next transfer
- [High] i2c: cs75xx: ignore NACK on the last byte of a write message
- [Medium] i2c: interrupts permanently disabled after timeout reset
- [Medium] i2c: cs75xx: ignore NACK on the last byte of a write message
--

commit 4bef5e4f9afb2c145bb402508760c2866f3f5a51
Author: Fil Dunsky <filipp.dunsky@gmail.com>

i2c: Add Cortina Systems CS75xx I2C controller driver

The I2C ("Bi-Wire") controller of the Cortina Systems CS75xx SoCs transfers
one byte per command, and raises an interrupt when a command has completed.
Messages are sent with a repeated start between them and a stop after the
last one. Arbitration loss is reported as -EAGAIN and retried by the core.

> diff --git a/drivers/i2c/busses/i2c-cs75xx.c b/drivers/i2c/busses/i2c-cs7=
5xx.c
> index 0000000000000..2d40f099d6715
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-cs75xx.c
[ ... ]
> +static void cs75xx_i2c_process(struct cs75xx_i2c *i2c, u32 ack)
> +{
> +	struct i2c_msg *msg =3D i2c->msg;
> +
> +	if (ack & CS75XX_I2C_ACK_AL) {
> +		writel(CS75XX_I2C_CTRL_STOP, i2c->base + CS75XX_I2C_CTRL);
> +		cs75xx_i2c_finish(i2c, -EAGAIN);
> +		return;
> +	}
> +
> +	switch (i2c->state) {
> +	case CS75XX_I2C_ADDR:
[ ... ]
> +	case CS75XX_I2C_WRITE:
> +		if (i2c->pos =3D=3D msg->len) {
> +			cs75xx_i2c_finish(i2c, 0);
> +			return;
> +		}
> +		if (ack & CS75XX_I2C_ACK_NACK) {

[Severity: High]
Does this early return ignore the NACK check for the last byte?

Since i2c->pos is incremented immediately after writing a byte to the TX
register, it equals msg->len during the interrupt that signals completion of
the final byte. If the target device NACKs the last byte, will the driver
falsely report a successful transfer instead of an error?

> +			writel(CS75XX_I2C_CTRL_STOP, i2c->base + CS75XX_I2C_CTRL);
> +			cs75xx_i2c_finish(i2c, -EIO);
> +			return;
> +		}
> +		cs75xx_i2c_next_byte(i2c);
> +		break;
[ ... ]
> +static irqreturn_t cs75xx_i2c_isr(int irq, void *dev_id)
> +{
> +	struct cs75xx_i2c *i2c =3D dev_id;
> +	u32 ctrl, ack;
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
> +
> +	spin_lock(&i2c->lock);

[Severity: High]
Can the STOP completion interrupt from an error in the previous transfer
race with the next transfer?

If a transfer fails (e.g. arbitration loss) and the ISR commands a STOP, the
waiting thread wakes up and the I2C core immediately retries. The thread
polls for !BUSY in cs75xx_i2c_xfer(), which becomes true exactly when the
STOP completes. The STOP completion simultaneously raises INT_DONE.

The thread proceeds, sets the state to ADDR, starts the new transfer, and
unlocks. Concurrently, the STOP completion ISR executes on another CPU,
reads the stale ACK locklessly, and spins on the lock. When the thread
unlocks, the ISR processes the stale ACK by incorrectly calling
cs75xx_i2c_next_byte(), which overrides the ADDR phase with a WRITE.

Does reading the ACK register locklessly before spin_lock() allow this stale
state to corrupt the newly started transfer?

> +	cs75xx_i2c_process(i2c, ack);
> +	spin_unlock(&i2c->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int cs75xx_i2c_xfer_msg(struct cs75xx_i2c *i2c, struct i2c_msg *m=
sg,
> +			       bool last)
> +{
[ ... ]
> +	time_left =3D wait_for_completion_timeout(&i2c->done, i2c->adap.timeout=
);
> +	if (!time_left) {
> +		spin_lock_irq(&i2c->lock);
> +		i2c->state =3D CS75XX_I2C_IDLE;
> +		spin_unlock_irq(&i2c->lock);
> +		dev_err(i2c->dev, "transfer timed out, resetting the controller\n");
> +		cs75xx_i2c_hw_init(i2c);

[Severity: Medium]
Will this hardware reset leave interrupts permanently disabled?

In cs75xx_i2c_hw_init(), the enable bit is cleared which performs a hardware
reset:

	if (readl(i2c->base + CS75XX_I2C_CFG) & CS75XX_I2C_CFG_EN) {
		writel(0, i2c->base + CS75XX_I2C_CFG);
		usleep_range(5000, 10000);
	}

Since cs75xx_i2c_xfer_msg() calls cs75xx_i2c_hw_init() on a timeout but does
not explicitly restore the interrupt enable (IE) register, will all
subsequent transfers time out as well?

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
> +	/*
> +	 * Let the stop condition of the previous transfer complete and drop
> +	 * its interrupt, so that it is not taken for the next address phase.
> +	 */
> +	if (readl_poll_timeout(i2c->base + CS75XX_I2C_ACK, val,
> +			       !(val & CS75XX_I2C_ACK_BUSY), 10, 1000))
> +		dev_dbg(i2c->dev, "bus still busy\n");

[Severity: High]
If the controller remains busy after the timeout, should the error code be
returned instead of proceeding?

By ignoring the return value of readl_poll_timeout(), the execution
continues and writes a START command to the controller while it is still
actively asserting BUSY. Can this violate the I2C protocol and cause
undefined hardware behavior?

> +	writel(CS75XX_I2C_INT_DONE, i2c->base + CS75XX_I2C_INT);
> +
> +	for (i =3D 0; i < num; i++) {
> +		ret =3D cs75xx_i2c_xfer_msg(i2c, &msgs[i], i =3D=3D num - 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
s2-v1-0-8a7641b7b79c@gmail.com?part=3D6
