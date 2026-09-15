Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D42EEE7C;
	Tue, 15 Sep 2026 03:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789444153; cv=none; b=A4u3HJcz0XzSJITyTJFX0RzRWZJPUkiQWJ1Hy/ZPekEf7PRyCTy7ewYqCWBVDzcuPNvbdtksRARWV5qgtn5YWOyp0kmAxNg6yf+NaXF1Eb2rOEEmnbQBG955B1QekJyQ0rucHmaD2Qn+QzAZtqu/h5TVu+rNTxnjzR8rBuJ076g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789444153; c=relaxed/simple;
	bh=h5N5q4HvNVaRgbC2UVfJb4iZm/FaQihDcPpIChS0iY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JiIv7TxkmsKjtwYQvmoL4CkFXPXFBRHsWb8r8NmLAL1IO22hR9jmBlUztvbhNvqmaia+ow1YNUDe5G8VQPQ3kfaQbkhU49v7bna2p5b+nJdoLRFrmajfxPXkqmm+LtkCX/6sCCVOqqG4nc+AxebK+o8Pw0TmhI0wVUWARbve9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzFn3kkm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzFn3kkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BCB1F000FF;
	Tue, 15 Sep 2026 03:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789444151;
	bh=h5N5q4HvNVaRgbC2UVfJb4iZm/FaQihDcPpIChS0iY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KzFn3kkmt0KxbES4dl3NjfDTu1ICAUdzw5DRmTVOQTAixKS+TwpbuKW+IJ5Xy+9j8
	 z3/XJR6ZzqORCUhs7ydGyzWKbkME9sgOLBlhokwag6qqPkooDlXKzb/LbM09l+OB1i
	 KaTyOXkf8XrUB9qZdn8AJaDgWkDxHe1xD5Mj9hagiz1pWnKyVDhA3kVfQ+BkYqy8aJ
	 k+2cgA+f4f/ThWms8c9a2X9YVrTeeMKIhX2C651We2YSswtNqjxrknVR3pDBPEypkF
	 rSi7znBQuEkXgTry1OiZ3+8H2CdVWXY9FtXjmltB2Y1OIe2bj27mgOLWWoSl7XBxcW
	 ir7kTy6IBZfwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/5] rtc: pcf85363: add oscillator offset calibration
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260915034452.4086683-4-lakshay.piplani@nxp.com>
References: <20260915034452.4086683-1-lakshay.piplani@nxp.com>
 <20260915034452.4086683-4-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:49:10 +0000
Message-Id: <20260915034911.21BCB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> Expose the oscillator offset register of PCF85263/PCF85363 through the
> read_offset and set_offset rtc_class_ops callbacks, so userspace can
> apply frequency correction for drift compensation.
>=20
> The offset is in parts per billion (ppb). CTRL_OFFSET is a signed 8-bit
> step count whose size depends on the OFFM bit: 2170 ppb/step normal and
> 2034.5 ppb/step fast, the latter computed with an x10-scaled constant to
> keep the arithmetic integer. Values are range-checked before that scaling
> so the multiply cannot overflow, and out-of-range values are rejected
> with -ERANGE rather than clamped.
>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915034452.4086=
683-1-lakshay.piplani@nxp.com?part=3D4

