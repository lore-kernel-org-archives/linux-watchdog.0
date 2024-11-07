Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09A71373;
	Thu,  7 Nov 2024 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.87.125.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977264; cv=none; b=ubuTf34+Ev0NkWiVADo7AbEYNhf8/zngkiExkwht1uQh3KtHC5XTeyD2zkOBKwCUJNuOPg9odNJ5JB0UKN574KsQh9jjqQYhXRPTti/fY2FbdGvWCATckcwcm+/3d8nuNZ6w0I4GsptCgFP2v2VfqrTxdISh2JsAlTbrUco4V70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977264; c=relaxed/simple;
	bh=bkxxQT0ywZ+RAU3jBxc18hVZFtgf6aogb7G4KtK1nhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNQyL7Yf/41jj8Xn9vL487imNIqz/Ikj+NWlIU6HIwTsPzsYmvA3umq5+E5N7rkc4C9LWBb09eS1vAd2lY3MlgPqHKJb1S/5b6SxsUIfTde+qiaOh9hh4VJ0U/OdvWC7CyFbuW7dyaIFnyQjIElR9f7sCAwpVHx3FhGjb8owBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=linux-watchdog.org; spf=pass smtp.mailfrom=linux-watchdog.org; dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b=QmV8O2Os; arc=none smtp.client-ip=185.87.125.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=linux-watchdog.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux-watchdog.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="QmV8O2Os"
Received: by www.linux-watchdog.org (Postfix, from userid 500)
	id 0485940A06; Thu,  7 Nov 2024 11:33:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 0485940A06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
	s=odk20180602; t=1730975612;
	bh=bkxxQT0ywZ+RAU3jBxc18hVZFtgf6aogb7G4KtK1nhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmV8O2OsnEKHTeXWL2yUMNdkZmtV18s3l1A0wMrvm/yCqpCvsfwDX1WwKx+YsZgmv
	 1D9NAG0ffFkeFhzcPoEbOuKInQOHo0AWuMmXPO7bIY0PcVyJ+gZ1WCi8FNqAqZ+eZu
	 SyFHUaZxyptoPue5zAt/M/pKYi0mId8MFOI9oMFI=
Date: Thu, 7 Nov 2024 11:33:31 +0100
From: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Taewan Kim <trunixs.kim@samsung.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Byoungtae Cho <bt.cho@samsung.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: exynosautov920: add watchdog DT node
Message-ID: <20241107103331.GA4818@www.linux-watchdog.org>
References: <20241021063903.793166-1-trunixs.kim@samsung.com>
 <CGME20241021063938epcas2p1c01c89badb532f08a46087a4907df7dc@epcas2p1.samsung.com>
 <20241021063903.793166-4-trunixs.kim@samsung.com>
 <961e1aca-cd90-4db1-87d7-afd2e542421e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <961e1aca-cd90-4db1-87d7-afd2e542421e@kernel.org>
User-Agent: Mutt/1.5.20 (2009-12-10)

Hi Krzystof,

> On 21/10/2024 08:39, Taewan Kim wrote:
> > From: Byoungtae Cho <bt.cho@samsung.com>
> > 
> > Adds two watchdog devices for ExynosAutoV920 SoC.
> > 
> > Signed-off-by: Byoungtae Cho <bt.cho@samsung.com>
> > Signed-off-by: Taewan Kim <trunixs.kim@samsung.com>
> > ---
> >  .../arm64/boot/dts/exynos/exynosautov920.dtsi | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> 
> How did this happen that this patch was taken to watchdog? There is no
> Ack here from me.
> 
> Drop this patch from watchdog, I do no agree to take it via that tree.
> 
> Best regards,
> Krzysztof
> 

Seems like you are having a hard day. 
The 3 patches are dropped. I presume that you will take them all through your tree then?

Kind regards,
Wim.

PS: the patches are:
[PATCH v3 1/3] dt-bindings: watchdog: Document ExynosAutoV920 watchdog bindings
[PATCH v3 2/3] watchdog: s3c2410_wdt: add support for exynosautov920 SoC
[PATCH v3 3/3] arm64: dts: exynosautov920: add watchdog DT node

