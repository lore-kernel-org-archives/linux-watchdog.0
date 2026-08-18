Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD42427FA1;
	Tue, 18 Aug 2026 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068590; cv=none; b=uHvk9KLdXkx4Pl6TgBBZ3MMDRXZFckcp1PxEikmtv1z2bov7JNo+AWigFBv1ZGxdzGZOzcqqrDEI3jkpXtfhOaw/xXd/bLxY7HxJFpXa+EiRBwValZ0Q3+8yDrjHkK5F2c4MnqJlgdbA9MqCEHDnJS0/EGgKV5s4T0FFkgV2LSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068590; c=relaxed/simple;
	bh=ITHc2CB/m5fMgg9+eyKTybFOkJJDIhAYm78SABpciCU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tKfxp/wIr6A37d09X27a78Tbo73T1e5SOMuC6W3qBwQxekYd4MPVhKpb6v2KVfXeQMMaUVm/lSmbJSYog8PGikRxg5t/P4w1b4+lNBtDcMaJpPG/kGEnIoNpkAdEDV8flI8qSQHHu39VjLQQiIxjrBU6M1qNqd7Rogl0HKHHdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIH/dKF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIH/dKF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6721F000E9;
	Tue, 18 Aug 2026 15:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787068589;
	bh=x3eQbbry7J496JIJ5mWdPf5mlzkiZpYKY/bOcBoEXVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XIH/dKF+9Vmk6yo4dOV7EY/iJnGIhqLoPE7Yr/QCAgqK+GulS5BcqrqjZyA71uSR3
	 FDNc/qcWozbCuXY3U5kW+hwTc31YbpOgXiazA1E3D9KUAigB5iDCfZ/+blfD0tsWs2
	 BUtpTSYZ2olx8M/WJx+ICH7XGDHTqYtgqZGczd4RUwL+nNUmMEjcco81P/81iMlZUD
	 IZhZEmS3q3JbyY3u9UvmD4j8Hqa5keMTRCLNu+zzgmE4XLWtxwKPb9MwjJByooP0PI
	 yqaL2z0mf5jOQJifHLwNo04TIXxhO3KRC7ModZHj2RannVRzAJRo+YA7Mwi7C+8yIr
	 2+HnSByJNSu6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: samsung-wdt: Add
 exynos5515-wdt compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aiden Isik" <aidenisik@member.fsf.org>
Cc: conor+dt@kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260818-for-next-lucky7-watchdog-v2-1-6743f479a47f@member.fsf.org>
References: <20260818-for-next-lucky7-watchdog-v2-0-6743f479a47f@member.fsf.org>
 <20260818-for-next-lucky7-watchdog-v2-1-6743f479a47f@member.fsf.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:56:28 +0000
Message-Id: <20260818155629.0A6721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `samsung,exynos5515-wdt` compatible string is defined as a s=
tandalone string without a fallback, but corresponding support is entirely =
missing from the watchdog driver.
--

--- Patch [1]: [PATCH v2 1/2] dt-bindings: watchdog: samsung-wdt: Add exyno=
s5515-wdt compatible ---
commit 1111ae2e418dde480b9a0bc5f9cb740eb0c3a137
Author: Aiden Isik <aidenisik@member.fsf.org>

dt-bindings: watchdog: samsung-wdt: Add exynos5515-wdt compatible

Add a dt-binding compatible for the Exynos5515 watchdog timer.

> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml =
b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> index 41aee1655b0c2..a32c478315779 100644
> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> @@ -22,6 +22,7 @@ properties:
>            - samsung,s3c6410-wdt                   # for S3C6410, S5PV210=
 and Exynos4
>            - samsung,exynos5250-wdt                # for Exynos5250
>            - samsung,exynos5420-wdt                # for Exynos5420
> +          - samsung,exynos5515-wdt

[Severity: Medium]
Does this standalone compatible string need a corresponding entry in the
watchdog driver to function?

Because there is no fallback compatible string provided in this binding, it
looks like the driver lacks a matching entry to probe the device. Looking at
the device ID table in drivers/watchdog/s3c2410_wdt.c:

drivers/watchdog/s3c2410_wdt.c
static const struct of_device_id s3c2410_wdt_match[] =3D {
    ...
	{ .compatible =3D "google,gs101-wdt",
	  .data =3D &drv_data_gs101_cl0 },
    ...
};

Without an addition to s3c2410_wdt_match or a suitable fallback string in
the device tree, will the Exynos5515 watchdog silently fail to probe and
leave the hardware unsupported at runtime?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-for-next-l=
ucky7-watchdog-v2-0-6743f479a47f@member.fsf.org?part=3D1
