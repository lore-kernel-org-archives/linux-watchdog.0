Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2015429023;
	Thu, 24 Sep 2026 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233134; cv=none; b=RKOtsl/NtGXwwDQk6RiFRzvaYQXbYmB8wAJDN9xUH+2vhqzHst+SfDGtYiQQfA49/E7I7OFmrpLtc3ELm1Lw3fL31LbYTjngucdSBcx14HFZUSYHqCuif+ZegwLeEh7+7OE7coUXUamJLke8iG5C+HXxMSlygpg9fJN6R3LMDt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233134; c=relaxed/simple;
	bh=mcN0HtGt6MkyvOXxEsZ4yRjlsZMFR3ubXhfKVjFQ37M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=amajVbfkVyfZql49GI/EDEAN5ofH4qPg7pYIQHuNamRc0e8Jc+SAZPRVnaYQCcaZ1sKaH+nfPoGoXiYCEBWD72FcKhITW/CWw+6pdoWomkSlxojQV8Fnrh6cQX0GjEPRnVGKNp2dEyZUyJ6HDmfoisGBEYHcFzyT3ml2Ew9+8v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8nuMlgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8nuMlgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ADD1F000FF;
	Thu, 24 Sep 2026 06:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790233122;
	bh=mcN0HtGt6MkyvOXxEsZ4yRjlsZMFR3ubXhfKVjFQ37M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G8nuMlgotjwqM4JMs42LGoTx6AogJ2tQ2Qma8Sv4/nw6+z8bsZoy5lsTddQ+4bIvt
	 sRnIdlVcv4l4lGDA2nBeL0oF6jlKHIkUZGNGrhavFgXGKDybOn8+vmk8W+/FnXyruE
	 MCCTBplVnDSyakRiocDXRnvNpv8VemloUw0VZPEppaUCqfuwArrOCbLCXV94d89tyd
	 7AnVCF0Xx7bhPClzK0ShWoXGWKmnvturI0VUvcg1a/PO5L3mXrBvnOrKVQjn1tK3wx
	 2oO/ZnERA40CfNa/tHbQaNhhnsOAitbmQ8UVqJVr9nYo6pi09nEQaUSG51LvZSxzkE
	 f+9Jlmj8AL88g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] mfd: da9062: Make register CONFIG_I writable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Primoz Fiser" <primoz.fiser@norik.com>
Cc: lee@kernel.org, imx@lists.linux.dev, robh@kernel.org, linux-watchdog@vger.kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260924065044.368341-2-primoz.fiser@norik.com>
References: <20260924065044.368341-1-primoz.fiser@norik.com>
 <20260924065044.368341-2-primoz.fiser@norik.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:58:41 +0000
Message-Id: <20260924065841.A9ADD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> From: Stefan Christ <s.christ@phytec.de>
>=20
> Make the config register CONFIG_I writable to change the watchdog mode.
>=20
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924065044.3683=
41-1-primoz.fiser@norik.com?part=3D1

