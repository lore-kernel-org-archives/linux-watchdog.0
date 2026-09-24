Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C4D41D10D;
	Thu, 24 Sep 2026 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233083; cv=none; b=dY5AQTYyS+JZQiNcqobqMnpDRYLhGVIny5UkA2Q52QkLM8Z8aa/mmsM0TKFWaoKVWVFzc9o6IJG1B6IXosC3Q53edEqeMPEYvm2QFFtQ5qka0jwluB4GXD+OISp1iMlrxCR9ZVFDVMPTwD3DaM/Uw2Nzv3j0XrQkJvDF4azGTso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233083; c=relaxed/simple;
	bh=r1cV9iFWeLaIVES256JEiZk7naRcBDBiUEQPITwNAXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W5TGDS3ZFUbaSlM5QRUmAACVLfjxjkHl6FZ9yWOveQ+fWn6sF/RxDYnwSHTLc7yLzGIqOH7QuGN+ZifkfhDNPrfUiDXAYu9puvwTqNWwRMTCaNduQAD2Q6sd+UE598v6G8LRTDvng3XPhZd8vfrseNxY4blkaP5Qq5whr2FV9nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUmL382Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUmL382Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43311F00893;
	Thu, 24 Sep 2026 06:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790233071;
	bh=r1cV9iFWeLaIVES256JEiZk7naRcBDBiUEQPITwNAXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hUmL382ZCWUYGmowzK5ZyzpoJ6tjZxXr2nFf2806wpeg7zU6yrHLbSub+sjte5S5g
	 MzNhLaVYrX5rXVWAmogkeracXCTiJtHRZmqKGiqTTOxdbwV+M8K9iBbDZuIkpZZWt4
	 LYjevtCtpMNMuVBwcF8QdF87VYtkerKuFjOvmcjmGpsnO6fQqUNBdex3HBffAc9RMm
	 0e7Rw6jlolCipnR5TucgV5AQYrdrRWHgF96//0+IFFd1wwEaLpK4ofn9JIQDJdB2SB
	 cBpczPDnGmOFEk2xOnPBIm9l0aqIBfJpFcHjCY7SM/bfsdciGSskPbXOz3nIBrCeaI
	 Y5lBqHRUXFEOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] ARM: dts: imx6: phycore-som: Set watchdog
 timeout mode to shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Primoz Fiser" <primoz.fiser@norik.com>
Cc: conor+dt@kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-watchdog@vger.kernel.org, robh@kernel.org, lee@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260924065044.368341-5-primoz.fiser@norik.com>
References: <20260924065044.368341-1-primoz.fiser@norik.com>
 <20260924065044.368341-5-primoz.fiser@norik.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:57:50 +0000
Message-Id: <20260924065750.A43311F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> From: Andrej Picej <andrej.picej@norik.com>
>=20
> Enable system restart when the watchdog timeout occurs.
>=20
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924065044.3683=
41-1-primoz.fiser@norik.com?part=3D4

