Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0A36EA88;
	Tue, 14 Jul 2026 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045480; cv=none; b=IRDBrpY4orC6ZSfs3T10hU62kHuVu39mNWxusmoFU7EwobXeraUWQGql9gVH3ei/96ZZSfOAhTed5el94Rm8IAXtjtvmmaYV+7TCtFFVKrlTVueTwseG8ofvRfaYZQEQ8OI9ZnMOx/dJMRGg53JrQwX0cg0lullNVapnSipknYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045480; c=relaxed/simple;
	bh=9Jupz2pz3rpmVJ2RkDeV6G4Jsuv3IgW1NMCtpicOL5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=brnp+yAPW3qu9DUQ00sKHYEGeK0SL2xlVRGPbc+dWx7eS6qkwkcfWrh6+5jIb6RRAJ6y9BcUQtM1JhJgcAu65TS/KvolqDMHv8kiil7UKSDatUGGhuH9eg57P9SQ8e1LT2PqoiRXgQm0t3cpP58Ika8hgXAtIDRgKiW9908bYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2FvZeNS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2FvZeNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188571F00A3A;
	Tue, 14 Jul 2026 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784045478;
	bh=bP813PqWGE4hbwxeUEuzsb08+vCc6RJ8tsVru+Mo02Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z2FvZeNS2VE0kpaK6NJaT9zqDFWmgYfggvB7wjGkGOzRb/E+yKwxdaL/KTI7HBJA0
	 9eAc56b+BypNNimlNjhVrgpP4Lamfr6k07tMCqegkTFWAAoNxOLwe15H4XAD+iP1KV
	 lDmAM5f+WcPPu8uovKQkANrZqUC85t0b7MzsRoa5imLZ8GItAjROo/OsKZgwN0w6NV
	 dbp6zyFIIr6vrmM3LrDmGu9nM9/mPklc+TU44RRFkUbPnbtfIHzAazbXqLvF7EKimc
	 U+o+7T02wfmW004DT+bLg0dmPnR+HETdlPSwJo9mMV6/4QeW7Yf76nSxOdwSdTB/fy
	 YNlHziUULw5mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] Add Advantech EIO I2C driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ramiro Oliveira" <ramiro.oliveira@advantech.com>
Cc: linux-hwmon@vger.kernel.org, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, lee@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260714-upstream-v2-v2-4-76e5e41026db@advantech.com>
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-4-76e5e41026db@advantech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 16:11:17 +0000
Message-Id: <20260714161118.188571F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 18 potential issue=
(s) to consider:
- [Critical] Reading SMBus block data via an `unsigned int *` cast causes o=
ut-of-bounds memory writes and stack corruption.
- [Critical] The driver does not validate the userspace-provided block leng=
th for SMBus block writes, allowing an out-of-bounds read of kernel memory.
- [High] Premature exit in `i2c_xfer` causes silent truncation of multi-mes=
sage I2C transactions.
- [High] Local mutex `pnp_mutex` fails to protect the shared MFD-level PNP =
configuration sequence from concurrent access by other child drivers.
- [High] Misuse of `regmap_update_bits` (`eio_reg_or`) on W1C status regist=
ers and with 0 masks acts as a no-op, failing to clear hardware errors.
- [High] Off-by-one boundary check strictly rejects valid maximum-length (3=
2-byte) SMBus block transfers.
- [High] The 10-bit I2C addressing implementation is structurally flawed, l=
osing the R/W bit, corrupting the address, and omitting Repeated Start.
- [High] Uninitialized stack variables in `smb_access` are returned to user=
space if regmap reads fail.
- [High] SMBus read emulation over I2C incorrectly marks the command byte p=
hase as a read operation.
- [High] The read phase for `I2C_SMBUS_BLOCK_PROC_CALL` is completely omitt=
ed, dropping the response data.
- [High] Destructive bitwise operation wipes out `SMB_REG_HC` configuration=
 during Block Process Call.
- [Medium] Incorrect endianness handling in SMBus Word Data and Process Cal=
l transfers corrupts data on big-endian architectures.
- [Medium] The hardware is left stuck in PNP Extended Configuration Mode if=
 any register access fails during `load_i2c`.
- [Medium] Clock configuration logic is structurally disjoint when the requ=
ested frequency equals exactly 30 kHz (`I2C_THRESHOLD_SCLH`), resulting in =
massive under-clocking.
- [Medium] Polling loops can falsely trigger timeout errors because they ev=
aluate expiration before executing the final register read.
- [Low] The block write formatting logic in `smbus_xfer` copies one byte pa=
st the end of the payload buffer.
- [Low] Module parameters for configuring I2C and SMBus frequencies are dec=
lared but completely ignored by the driver logic.
- [Low] Driver-specific header file is inappropriately placed in the global=
 MFD include directory.
--

--- Patch [4]: [PATCH v2 4/8] Add Advantech EIO I2C driver ---
commit 0b05c6638fad42a025d75120571d2def944319c3
Author: Ramiro Oliveira <ramiro.oliveira@advantech.com>

    Add Advantech EIO I2C driver
   =20
    This commit adds the driver to control the Advantech EIO I2C block, this
    block is included in the Advantech EIO MFD.

> diff --git a/drivers/i2c/busses/i2c-eio.c b/drivers/i2c/busses/i2c-eio.c
> new file mode 100644
> index 0000000000000..56a89ca18f328
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-eio.c
> @@ -0,0 +1,1135 @@
> +// SPDX-License-Identifier: GPL-2.0-only
[ ... ]
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/eio.h>

[Severity: Low]
Does this include violate MFD architectural guidelines? The subsystem guide
specifies that driver-specific header files should be kept local to
drivers/mfd/ and not placed in the global include/linux/mfd/ directory if
they are only used by the parent and its immediate children.

[ ... ]
> +struct eio_i2c_dev {
> +	struct device *dev;
> +	struct device *mfd;
> +	struct regmap *regmap;
> +	struct mutex pnp_mutex; /* Mutex for PNP acces */

[Severity: High]
Since this mutex is initialized locally within the I2C child driver, does it
fail to protect the shared MFD-level PNP configuration registers (0x299/0x2=
9A)
from concurrent access by other sibling drivers (like GPIO or HWMON)?

[ ... ]
> +static int wait_busy(struct eio_i2c_chan *i2c_chan)
> +{
> +	ktime_t time_end =3D ktime_add_us(ktime_get(), I2C_TIMEOUT);
> +	unsigned int reg =3D eio_chan_reg(i2c_chan, I2C_REG_STAT, SMB_REG_HS);
> +	unsigned int target =3D eio_chan_reg(i2c_chan, I2C_STAT_BUSY, SMB_HS_BU=
SY);
> +	unsigned int val;
> +	int cnt =3D 0;
> +
> +	do {
> +		fsleep(cnt++);
> +
> +		if (ktime_after(ktime_get(), time_end)) {
> +			dev_err(eio_dev(i2c_chan), "Wait I2C bus busy timeout\n");
> +			return -ETIME;
> +		}
> +
> +		if (eio_reg_read(i2c_chan, reg, &val))
> +			return -EIO;
> +
> +	} while (val & target);

[Severity: Medium]
Could this polling loop falsely return a timeout? If the thread experiences
latency during the sleep and the timer expires, the loop will exit with an
error without performing a final register read to check if the hardware
actually completed the operation.

[ ... ]
> +static void i2c_clear(struct eio_i2c_chan *i2c_chan)
> +{
> +	if (is_i2c(i2c_chan)) {
> +		eio_reg_write(i2c_chan, I2C_REG_STAT, 0xFF);
> +	} else {
> +		eio_reg_or(i2c_chan, SMB_REG_HS,  0xA9);
> +		eio_reg_or(i2c_chan, SMB_REG_HS2, 0x4C);
> +	}
> +}

[Severity: High]
Does using a read-modify-write operation (eio_reg_or -> regmap_update_bits)
work for clearing Write-1-to-Clear (W1C) bits? If the bits are already set
in the hardware, reading them and writing back the same value will often be
skipped by regmap, leaving the errors uncleared.

[ ... ]
> +static int wait_write_done(struct eio_i2c_chan *i2c_chan, bool no_ack)
> +{
> +	ktime_t time_end =3D ktime_add_us(ktime_get(), I2C_TIMEOUT);
> +	unsigned int val =3D 0;
> +	int cnt =3D 0;
> +	unsigned int reg =3D eio_chan_reg(i2c_chan, I2C_REG_STAT, SMB_REG_HS);
> +	unsigned int target =3D eio_chan_reg(i2c_chan, I2C_STAT_TXDONE, SMB_HS_=
TX_DONE);
> +
> +	do {
> +		fsleep(cnt++);
> +		if (ktime_after(ktime_get(), time_end)) {
> +			if (is_i2c(i2c_chan)) {
> +				eio_reg_or(i2c_chan, I2C_REG_STAT, 0);

[Severity: High]
Is it possible this fails to clear the status flags? Passing a mask of 0 to
regmap_update_bits will result in no bits being changed, and the write will
likely be optimized out entirely.

[ ... ]
> +static int set_freq(struct eio_i2c_chan *i2c_chan, int freq)
> +{
> +	u8 pre1, pre2;
> +	u16 speed;
> +	unsigned int reg1 =3D eio_chan_reg(i2c_chan, I2C_REG_PRESCALE1, SMB_REG=
_HPRESCALE1);
> +	unsigned int reg2 =3D eio_chan_reg(i2c_chan, I2C_REG_PRESCALE2, SMB_REG=
_HPRESCALE2);
> +
> +	dev_dbg(eio_dev(i2c_chan), "set freq: %dkHz\n", freq);
> +	if (freq > I2C_FREQ_MAX || freq < I2C_FREQ_MIN) {
> +		dev_err(eio_dev(i2c_chan), "Invalid i2c freq: %d\n", freq);
> +		return -EINVAL;
> +	}
> +
> +	speed =3D (freq < I2C_THRESHOLD_SCLH) ? I2C_SCLH_LOW : I2C_SCLH_HIGH;
> +
> +	pre1 =3D (u8)(CHIP_CLK / speed);
> +	pre2 =3D (u8)((speed / freq) - 1);
> +
> +	if (freq > I2C_THRESHOLD_SCLH)
> +		pre2 |=3D I2C_SCL_FAST_MODE;

[Severity: Medium]
What happens if the requested frequency is exactly 30 kHz (I2C_THRESHOLD_SC=
LH)?
The first check (< 30) evaluates to false, making speed 2500. However, the
second check (> 30) also evaluates to false, failing to set the FAST_MODE b=
it.
Will this combination drastically underclock the bus?

[ ... ]
> +static int smb_access(struct eio_i2c_chan *i2c_chan, u8 addr, bool is_re=
ad, u8 cmd,
> +		      int size, union i2c_smbus_data *data)
> +{
> +	int i, tmp, ret =3D 0;
[ ... ]
> +	case I2C_SMBUS_BLOCK_DATA:
> +		dev_dbg(eio_dev(i2c_chan), "I2C_SMBUS_BLOCK_DATA\n");
> +		if (is_read)
> +			break;
> +
> +		/* Program command type */
> +		eio_reg_read(i2c_chan, SMB_REG_HC, (unsigned int *)&tmp);
> +		tmp &=3D ~(0x07 << SMB_HC_CMD_SHIFT);
> +		tmp |=3D  (size << SMB_HC_CMD_SHIFT);
> +		eio_reg_write(i2c_chan, SMB_REG_HC, tmp);
> +
> +		/* Force write for payload stage */
> +		eio_reg_write(i2c_chan, SMB_REG_HADDR, addr & ~0x01);
> +
> +		/* Reset internal buffer index pointer */
> +		eio_reg_and(i2c_chan, SMB_REG_HC2, (int)~SMB_HC2_E32B);
> +		eio_reg_or(i2c_chan, SMB_REG_HC2, SMB_HC2_E32B);
> +
> +		/* Write length + data */
> +		eio_reg_write(i2c_chan, SMB_REG_HD0, data->block[0]);
> +		for (i =3D 1; i <=3D data->block[0]; i++)
> +			eio_reg_write(i2c_chan, SMB_REG_HBLOCK, data->block[i]);

[Severity: Critical]
Does this loop need to validate the length of data->block[0] against
I2C_SMBUS_BLOCK_MAX before writing? Without bounds checking, this may blind=
ly
read past the union's memory boundary and dump kernel stack contents onto t=
he
I2C bus.

> +		break;
> +
> +	case I2C_SMBUS_BLOCK_PROC_CALL:
> +		/* Set command type field */
> +		eio_reg_and(i2c_chan, SMB_REG_HC, (0x07 << SMB_HC_CMD_SHIFT));

[Severity: High]
Does this bitwise operation wipe out configuration flags? Because eio_reg_a=
nd
uses regmap_update_bits with an inverted mask, providing only the command b=
its
implies all other active control bits in the register will be zeroed out.

> +		eio_reg_write(i2c_chan, SMB_REG_HD0, data->block[0]);
> +
> +		/* Reset buffer index */
> +		eio_reg_and(i2c_chan, SMB_REG_HC2, (int)~SMB_HC2_E32B);
> +		eio_reg_or(i2c_chan, SMB_REG_HC2, SMB_HC2_E32B);
> +
> +		for (i =3D 1; i <=3D data->block[0]; i++)
> +			eio_reg_write(i2c_chan, SMB_REG_HBLOCK, data->block[i]);

[Severity: Critical]
Similar to the block data write above, does data->block[0] need bounds chec=
king
here to prevent out-of-bounds kernel memory reads?

[ ... ]
> +	switch (size) {
> +	case I2C_SMBUS_QUICK:
> +		dev_dbg(eio_dev(i2c_chan), "I2C_SMBUS_QUICK\n");
> +		break;
> +
> +	case I2C_SMBUS_BYTE:
> +	case I2C_SMBUS_BYTE_DATA:
> +		if (is_read) {
> +			unsigned int v;
> +
> +			dev_dbg(eio_dev(i2c_chan), "I2C_SMBUS_BYTE/I2C_SMBUS_BYTE_DATA\n");
> +			eio_reg_read(i2c_chan, SMB_REG_HD0, &v);
> +			data->block[0] =3D (u8)v;

[Severity: High]
If eio_reg_read fails (e.g. from a hardware error), the error is ignored and
the uninitialized stack variable 'v' will be copied into data->block[0]. Wi=
ll
this leak uninitialized kernel memory to userspace during an ioctl?

> +			dev_dbg(eio_dev(i2c_chan), "read %X\n", data->block[0]);
> +		}
> +		break;
> +
> +	case I2C_SMBUS_WORD_DATA: {
> +		unsigned int v0, v1;
> +
> +		if (is_read) {
> +			dev_dbg(eio_dev(i2c_chan), "I2C_SMBUS_WORD_DATA\n");
> +			eio_reg_read(i2c_chan, SMB_REG_HD0, &v0);
> +			eio_reg_read(i2c_chan, SMB_REG_HD1, &v1);
> +			data->block[0] =3D (u8)v0;
> +			data->block[1] =3D (u8)v1;

[Severity: Medium]
Is it safe to assign word bytes directly into the data->block byte array?
Because data->block shares a union with the 16-bit data->word, this mappings
changes based on host endianness. Will this corrupt word values on big-endi=
an
architectures?

[Severity: High]
Also, just like the byte read case, an error in eio_reg_read will cause the
uninitialized stack variables v0 and v1 to be returned to the client.

> +		}
> +		break;
> +	}
> +
> +	case I2C_SMBUS_PROC_CALL: {
> +		unsigned int v0, v1;
> +
> +		dev_dbg(eio_dev(i2c_chan), "I2C_SMBUS_PROC_CALL\n");
> +		eio_reg_read(i2c_chan, SMB_REG_HD0, &v0);
> +		eio_reg_read(i2c_chan, SMB_REG_HD1, &v1);
> +		data->block[0] =3D (u8)v0;
> +		data->block[1] =3D (u8)v1;

[Severity: Medium]
Similar endianness handling issue exists here for Process Call responses.

[Severity: High]
And once again, uninitialized memory leaks are possible if the reads fail.

> +		break;
> +	}
> +
> +	case I2C_SMBUS_BLOCK_DATA:
> +		if (!is_read)
> +			break;
> +
> +		dev_dbg(eio_dev(i2c_chan), "I2C_SMBUS_BLOCK_DATA\n");
> +		eio_reg_read(i2c_chan, SMB_REG_HD0, (unsigned int *)&len);
> +		len =3D min(len, I2C_SMBUS_BLOCK_MAX);
> +		data->block[0] =3D len;
> +
> +		for (i =3D 1; i <=3D len; i++)
> +			eio_reg_read(i2c_chan, SMB_REG_HBLOCK,
> +				     (unsigned int *)&data->block[i]);

[Severity: Critical]
Is it safe to cast the 8-bit array slot pointer &data->block[i] to a 32-bit
unsigned int * ? When regmap_read populates the result, it will write 32 bi=
ts,
causing it to overwrite up to 3 bytes past the end of the union i2c_smbus_d=
ata
structure on the final iterations, corrupting the stack.

> +		break;
> +
> +	default:
> +		ret =3D -EINVAL;
> +		goto exit;
> +	}

[Severity: High]
Is the read phase for I2C_SMBUS_BLOCK_PROC_CALL intentionally missing? The
switch statement falls through to default, throwing away the response data =
and
returning an error.

[ ... ]
> +static int i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int =
nmsgs)
> +{
[ ... ]
> +	for (msg =3D 0; msg < nmsgs; msg++) {
> +		int is_read =3D msgs[msg].flags & I2C_M_RD;
> +		bool no_ack =3D msgs[msg].flags & I2C_M_IGNORE_NAK;
> +
> +		dev_dbg(eio_dev(i2c_chan), "message %d len=3D%d\n", msg, msgs[msg].len=
);
> +
> +		if (!msgs[msg].len)
> +			let_stop(i2c_chan);
> +
> +		if (msgs[msg].flags & I2C_M_TEN) {
> +			addr =3D eio_enc_10bit_addr(msgs[msg].addr);
> +			addr |=3D is_read;
> +			dev_dbg(eio_dev(i2c_chan), "10-bit addr: %X\n", addr);
> +
> +			ret =3D write_addr(i2c_chan, addr >> 8, no_ack);
> +			if (!ret)
> +				ret =3D write_data(i2c_chan, addr & 0x7F, no_ack);

[Severity: High]
Is this 10-bit addressing logic accurate? ORing the read flag into the lower
byte, dropping the upper bit via a shift, and masking the bottom bits seems=
 to
corrupt the address format. Additionally, shouldn't there be a Repeated Sta=
rt
phase explicitly generated for reads?

> +		} else {
> +			addr =3D eio_enc_7bit_addr(msgs[msg].addr);
> +			addr |=3D is_read;
> +			dev_dbg(eio_dev(i2c_chan), "7-bit addr: %X\n", addr);
> +
> +			ret =3D write_addr(i2c_chan, addr, no_ack);
> +		}
> +
> +		if (ret)
> +			goto exit;
> +
> +		if (!msgs[msg].len)
> +			goto exit;

[Severity: High]
Will exiting here prematurely abort multi-message transfers? For 0-length p=
robe
messages, this breaks out of the loop over nmsgs, failing to process any
subsequent messages while still returning success.

> +
> +		if (is_read)
> +			ret =3D eio_trigger_read(i2c_chan, (u32 *)&dummy);
> +
> +		/* Transmit all messages */
> +		for (data =3D 0; data < msgs[msg].len; data++) {
> +			if (msgs[msg].flags & I2C_M_RD) {
> +				bool last =3D (msgs[msg].len =3D=3D data + 1);
> +
> +				if (last)
> +					let_stop(i2c_chan);
> +
> +				ret =3D read_data(i2c_chan, &msgs[msg].buf[data]);
> +				dev_dbg(eio_dev(i2c_chan), "I2C read[%d] =3D %x\n",
> +					data, msgs[msg].buf[data]);
> +
> +				/* Don't stop twice */
> +				if (last && ret =3D=3D 0)
> +					goto exit;

[Severity: High]
Similarly, doesn't this goto break out of the nmsgs loop entirely? If a read
message is followed by further messages in a single I2C transaction, those
remaining messages will be silently ignored.

[ ... ]
> +static int smbus_xfer(struct i2c_adapter *adap, u16 addr,
> +		      u16 flags, char is_read, u8 cmd,
> +		      int size, union i2c_smbus_data *data)
> +{
[ ... ]
> +	if (data) {
> +		buf[0] =3D cmd;
> +		/* FIX: preserve other flags; only toggle I2C_M_RD */
> +		msgs[0].flags =3D is_read ? (flags | I2C_M_RD) : (flags & ~I2C_M_RD);

[Severity: High]
Does this break the semantic structure of an SMBus read transaction? Setting
I2C_M_RD on the first message (the command byte phase) means it will be sen=
t to
the device as an I2C read rather than an I2C write, causing emulated SMBus =
reads
to fail entirely.

[ ... ]
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +	case I2C_SMBUS_I2C_BLOCK_BROKEN:
> +		dev_dbg(eio_dev(i2c_chan), "I2C_SMBUS_I2C_BLOCK_(DATA/BROKEN) on I2C l=
en=3D%d\n",
> +			data->block[0]);
> +		if (!data)
> +			return -EINVAL;
> +		msgs[0].len =3D is_read ? 1 : data->block[0] + 1;
> +		msgs[1].len =3D data->block[0];
> +		msgs[1].buf =3D data->block + 1;
> +		if (msgs[0].len >=3D I2C_SMBUS_BLOCK_MAX ||
> +		    msgs[1].len >=3D I2C_SMBUS_BLOCK_MAX)
> +			return -EINVAL;

[Severity: High]
Does this boundary check strictly reject valid 32-byte payloads? Since
I2C_SMBUS_BLOCK_MAX is 32, using >=3D instead of > causes perfectly valid
maximum-length transfers to fail with -EINVAL.

> +		if (!is_read)
> +			memcpy(buf + 1, data->block + 1, msgs[0].len);

[Severity: Low]
Since msgs[0].len is set to data->block[0] + 1, won't copying msgs[0].len b=
ytes
from data->block + 1 pull one extra uninitialized byte from past the end of=
 the
populated payload?

[ ... ]
> +static int load_i2c(struct device *dev, enum eio_chan_id id,
> +		    struct eio_i2c_chan *i2c_chan)
> +{
[ ... ]
> +	/* Read channel I/O base via shared PNP window */
> +	mutex_lock(&eio_i2c->pnp_mutex);
> +	if (regmap_write(map, REG_PNP_INDEX, REG_EXT_MODE_ENTER) ||
> +	    regmap_write(map, REG_PNP_INDEX, REG_EXT_MODE_ENTER) ||
> +	    regmap_write(map, REG_PNP_INDEX, REG_LDN) ||
> +	    regmap_write(map, REG_PNP_DATA,  ldn) ||
> +	    regmap_write(map, REG_PNP_INDEX, REG_BASE_HI) ||
> +	    regmap_read(map,  REG_PNP_DATA,  &base_hi) ||
> +	    regmap_write(map, REG_PNP_INDEX, REG_BASE_LO) ||
> +	    regmap_read(map,  REG_PNP_DATA,  &base_lo) ||
> +	    regmap_write(map, REG_PNP_INDEX, REG_EXT_MODE_EXIT)) {
> +		mutex_unlock(&eio_i2c->pnp_mutex);
> +		dev_err(dev, "error read/write I2C[%d] IO port\n", id);
> +		return -EIO;
> +	}

[Severity: Medium]
If any of these hardware accesses fail, the logical OR sequence short-circu=
its.
Doesn't this mean the REG_EXT_MODE_EXIT command is never sent, leaving the =
Super
I/O controller permanently stuck in configuration mode?

> +	mutex_unlock(&eio_i2c->pnp_mutex);
> +
> +	base =3D (base_hi << 8) | base_lo;
> +	if (base =3D=3D 0xFFFF || base =3D=3D 0) {
> +		dev_dbg(dev, "i2c[%d] base addr=3D%#x (not in-use)\n", id, base);
> +		return -ENODEV;
> +	}
> +
> +	dev_dbg(dev, "i2c[%d] base addr=3D%#x\n", id, base);
> +
> +	/* Bind channel (no per-chan dev) */
> +	i2c_chan->base =3D (u16)base;
> +	i2c_chan->id   =3D id;
> +
> +	/* Per-channel frequency policy */
> +	if (i2c_chan->freq_override !=3D USE_DEFAULT)
> +		set_freq(i2c_chan, i2c_chan->freq_override);

[Severity: Low]
Does this actually have an effect? It appears i2c_chan->freq_override is
unconditionally initialized to USE_DEFAULT in the probe function just before
this is called, rendering the check dead code and ignoring user-provided mo=
dule
parameters.

[ ... ]
> +static int eio_i2c_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	for (ch =3D EIO_I2C0; ch < MAX_I2C_SMB; ch++) {
> +		struct eio_i2c_chan *i2c_chan;
> +
> +		i2c_chan =3D devm_kzalloc(dev, sizeof(*i2c_chan), GFP_KERNEL);
> +		if (!i2c_chan) {
> +			ret =3D -ENOMEM;
> +			break;
> +		}
> +
> +		i2c_chan->parent =3D eio_i2c;
> +		i2c_chan->freq_override =3D USE_DEFAULT;

[Severity: Low]
This initialization unconditionally overrides any module parameters provide=
d by
the system administrator.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-upstream-v=
2-v2-0-76e5e41026db@advantech.com?part=3D4
