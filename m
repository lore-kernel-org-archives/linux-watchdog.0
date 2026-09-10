Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBD313540;
	Thu, 10 Sep 2026 05:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017247; cv=none; b=abzbm7hWbI2qvfWHq/pgh3c/WZicutGeeMaZqsvEoDWVxa6S6nPsEtlY5K4knOSCdgYQXf6+P4JfuyUZ504zwpYWVBr3YMWwTxcV46HNsGBilnYaeFIvROy5+vHqmh2+IrMGm6KS35trAVjHUhdR3MAJmS70OZdtsmX4uhFYA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017247; c=relaxed/simple;
	bh=GfdPzHGGVB0+gLHKqa4BuzxuhJDsYjHHytcNKxlaHO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZJWHhjHVW7aSEoQ1nL27Tt6JgVbzz26uxVdKVf+havkF284fwn8BgF79HtOz5Ir/ITkjQY3kJT/YEpKZwPPvxGUx4YZ/74MRc+vnCTinEaPt4BYsje73dXg7/P21f8jiRR1ErpAS+dxzHTKf7SEDhiPOLAJZvozZN22+mMBsrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGxnjTSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGxnjTSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD60A1F000FF;
	Thu, 10 Sep 2026 05:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789017246;
	bh=GfdPzHGGVB0+gLHKqa4BuzxuhJDsYjHHytcNKxlaHO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EGxnjTSZao5aCxf8ZW5pm4TpwNL3wlKUt4DDoSdG7E8TcvUq6pidbEtnuL5tW3FbM
	 YZusOV+ee7z9/BaHDbv2bTrMpetzI1eHtH5F9gYiroS17ZJNlP6msKo6FOmeSKN9PU
	 QA1YYz9+xPTer4/H4xEZhRiWqn/8PEn8EfIPglHv9wALr+SxvIjq/9JSUw7OYrpuJc
	 VU9qvorRkYbNmPloYmfM1VwfBp0vMIVqv09xgFJXkKxsEOI0BoIdGkTF6x6yGVnBNp
	 64ieiB9SJUuUPpj1Grd4RxVupYxOwtaRtWqErY/QESgJgrl8QRHMjEJMjUkbeFRq5U
	 SKoqxs6QDG9bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] rtc: pcf85363: add oscillator offset calibration
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260910050747.1901440-4-lakshay.piplani@nxp.com>
References: <20260910050747.1901440-1-lakshay.piplani@nxp.com>
 <20260910050747.1901440-4-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 05:14:05 +0000
Message-Id: <20260910051405.CD60A1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910050747.1901=
440-1-lakshay.piplani@nxp.com?part=3D4

