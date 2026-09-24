Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97203426D0A;
	Thu, 24 Sep 2026 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233167; cv=none; b=m4FkkC67SOc0eFkyG2hT9hfg+zfKeEWZF1wuVdrN1/LBLe4UEW0ff74oz9sjs9hfOwq1bAkQhpI+Z8vJtITL22SVoAF6HK9PceuCqH5LBC4sRTBRztDMLJPwV3kYw4CxCd7QlCwjJU/w9pkr84enL0zoO0uYqMVJXFftlOYcBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233167; c=relaxed/simple;
	bh=6kqLVuMTkJMTqDTEpBxXxO4MeaXZjz1G7lVpuMoCXME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ek4j4zYVSnuXMkDka7t+7CWaEg6HUwT9KYDxCk7uQuMO0zrYpEcmrNuIVNpqRaPSbqHflc2CcMGRGnoUSVsPUpojRWtacg/HMrADTgRgJBWMaiJTvWsvlaUlH/myPLSP3xrRO8iogN4LhiEBVKh36nRKvDeoharPBlxA1O8XcMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRJchEsD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRJchEsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9549E1F000FF;
	Thu, 24 Sep 2026 06:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790233153;
	bh=6kqLVuMTkJMTqDTEpBxXxO4MeaXZjz1G7lVpuMoCXME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GRJchEsDLRVWka3Id2YYpHNjmXaWNbvtqvPRsOhbteqQ45O7HHnWbUALkudCug+lN
	 AJkeVPv9kEUgOqXDxddo8QrGHQAom7zPGa1347hV8POfYYugf9b2AKtCjKNvtB6Uou
	 8skP2QvilRN2m3JFAHrgkh+NGEfOiqRIsUAx/UZKZhHzUM8w2IZlm/BTISxl5wPX2j
	 w6aw6S2iUlqyqCm7t7t2V1aOSSUzIepK/kV8UXiAprwGUD8cvbuLJrmTyFVo8IMXci
	 fbzPTfG9vW9Zzrw9UgiErGPHgvo3X+ODSFVeLWKpWbDNkZDnap6Zv/ucjb94IsZwEI
	 X7ST2Xb1U/lmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] mfd: da9061: Make register CONFIG_I writable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Primoz Fiser" <primoz.fiser@norik.com>
Cc: lee@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, Frank.Li@kernel.org, mfd@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260924065044.368341-3-primoz.fiser@norik.com>
References: <20260924065044.368341-1-primoz.fiser@norik.com>
 <20260924065044.368341-3-primoz.fiser@norik.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:59:12 +0000
Message-Id: <20260924065912.9549E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> From: Andrej Picej <andrej.picej@norik.com>
>=20
> Make the config register CONFIG_I writable to change the watchdog mode.
>=20
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Tested-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924065044.3683=
41-1-primoz.fiser@norik.com?part=3D2

