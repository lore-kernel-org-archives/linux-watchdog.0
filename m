Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE1F41F5ED;
	Thu, 24 Sep 2026 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232999; cv=none; b=oXkpdYzD5ltscuKYm00aIP1XGy1QGI5528XFYXT8zZPLiRkfXtJb0v8dET8HfR88YWb+Mh4GF9lf4VWUcbO7YbLGSR4J1I+vjVc2XsGXVwl+voFjpBosYt+zsRdax/r0ZsUvFO4KSzVVy/WAyCq4F6ZblUmdKanSh19jw/dKP3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232999; c=relaxed/simple;
	bh=bX081ZKWgNQtGGP28XybBlmLfHfPvfRPj7aDL+oq5Yw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NrdOI6GVkSeM5c1UrRSmOytpx5pgl9F3WcK3i3nM9K4uf1mA/vjDyulgB9eetS0Bh7rmj5t0DxmffoLK4e61E6if8WyLEgtZ/N3jOOVR4MaV82Uas+mKpe5b8XP32Ug1ikrtUp2V0ItS92UMzsNohuGRTsIaU7OBVvjG26l3UXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXW8VCwX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXW8VCwX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141CA1F00899;
	Thu, 24 Sep 2026 06:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790232984;
	bh=bX081ZKWgNQtGGP28XybBlmLfHfPvfRPj7aDL+oq5Yw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YXW8VCwX0/3kuj8uSA78eSFXQSGNh6j1vw4nptKLkk1AMQ8hWV2h+CMkfCyqzhs+3
	 CIcd0OewpgsPsTHHV+3aRtiZrMJ379WYsoosrLLnQ43LVcNzgI0R+3pQ5gNOlBL/gb
	 XsokHc3jV5P1t0bgL4A2k3HH7VPSI17rqcY4FPYiRtW/wpb8MBt3/LDhm4Vkm5y+jv
	 tIb2K6dAUccjanKxqSdEQfuC1Br/6+Xy02q9fx8d44qURhlkQvKk9V7fm/m85xWdH/
	 rjxlTWfDM+us6rZx1V13BulKs09mMYOckYPAj/oEc3EzuEX7uguS6zIF6DnLEORigd
	 zRnMQziWDJTzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] watchdog: da9062: Add support for dlg,wdt-sd
 property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Primoz Fiser" <primoz.fiser@norik.com>
Cc: Frank.Li@kernel.org, lee@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, imx@lists.linux.dev, linux-watchdog@vger.kernel.org, mfd@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260924065044.368341-4-primoz.fiser@norik.com>
References: <20260924065044.368341-1-primoz.fiser@norik.com>
 <20260924065044.368341-4-primoz.fiser@norik.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:56:23 +0000
Message-Id: <20260924065624.141CA1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> From: Andrej Picej <andrej.picej@norik.com>
>=20
> Implement a method to change watchdog timeout configuration based on the
> "dlg,wdt-sd" devicetree property. Setting the WATCHDOG_SD bit enables
> SHUTDOWN mode, and clearing it enables POWERDOWN mode on watchdog
> timeout.
>=20
> If no devicetree property is specified, the WATCHDOG_SD bit stays in the
> default configuration, not breaking behaviour of devices which might
> depend on default fuse configuration.
>=20
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Tested-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924065044.3683=
41-1-primoz.fiser@norik.com?part=3D3

