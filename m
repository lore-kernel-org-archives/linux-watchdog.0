Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F54657D8;
	Thu, 10 Sep 2026 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055007; cv=none; b=uA7L3uipSdHcQiSudVlh721dgGx+xDEu2+NzHmpsrIWOteM1ipjvE7DRnXVsM+gIQb9O52L4DaQdx7e5WJ/ad6mp/iA11G1vGg6KdQ/Li2aDyZgFmLwCJx0nUysXZxapoIJKhzbsKOQIH/mHHkt3Hxh350XOYQqIu2xmuFAZ32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055007; c=relaxed/simple;
	bh=9UOhAIXK6/9A5779k61i/CwVD96UA/Cc2lv93fWnBp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJSYXaCdRm83hBML1EmZ9H6dBgC0FZsqAiUEtI050B/yAfT2rFZ7k5OIAMAF1xPK2lOU5iHL+S8oJamunlTVXPqZyMcQRpo5QxA3celbe1YgqSITyfRK68Zzm3kVJT4eHv4DBcqzVc7uOKVkHbgigdOVug0HNXlLDCQfzvFPKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WwH39bHv; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WwH39bHv"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hghlt2JcqzKv7Z;
	Thu, 10 Sep 2026 17:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789055002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4VVORHQ5nAbfeqleOeps/r2k+thyP0gIBZKzTnB2RHE=;
	b=WwH39bHvGFn/jDvnxeWJrNgOJvaqMjc6KU79h0wQ+Bmif7GS1DJSjfNNrfcx34x1ylpy0t
	8qnanM5nwpcve35U70qZrU4dp383Zhwoxrb7ZRHKo4W0yL7YCusrq0wAawCGOh/wQqLM+d
	Q+6KhCtx01nmK0TfDQPVvOlSC5/2RE8ZjtMqe4H8P5XUAgueG9IQ1yQjCTGIyOX8vAodtc
	8nqRGvVBrOjavlkyT62883Jn9IuwljGdDtKmz11XeFSvgd4mDx2VkeoSaMPxwcPBawxgE/
	L/v6CcuL7i6s85uuPZdUPUR2BOhs3VJMSBxrNFb14/sdZ2rjGBIx3Ia4qMrhwQ==
Date: Thu, 10 Sep 2026 17:43:19 +0200
From: Zakariya Hadrami <zkh@mailbox.org>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5 3/4] ARM: dts: mediatek: mt8127: Add watchdog support
Message-ID: <aqK4UNWoiGZhU4-e6wy078-zkh@mailbox.org>
References: <20260910-mt8127-amazon-ford-basic-v5-0-3cb9eeaffd5c@mailbox.org>
 <20260910-mt8127-amazon-ford-basic-v5-3-3cb9eeaffd5c@mailbox.org>
 <20260910133604.A1E861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910133604.A1E861F000FF@smtp.kernel.org>
X-MBO-RS-META: oq1odsg1fticq7yj8kk1qtiqm1tgxkxe
X-MBO-RS-ID: b69a4c5ff1b9bc133dc

On Thu, Sep 10, 2026 at 01:36:04PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The watchdog node is disabled by default in the SoC .dtsi, which is a device tree anti-pattern for internal IPs without board-specific dependencies.
> --
> 
> commit 00ce16ebfa121cfaa7d2f6798bebf7e7aabf4c90
> Author: Zakariya Hadrami <zkh@mailbox.org>
> 
> ARM: dts: mediatek: mt8127: Add watchdog support
> 
> This commit adds the watchdog node for MT8127 and explicitly disables it by
> default in the SoC dtsi.
> 
> > diff --git a/arch/arm/boot/dts/mediatek/mt8127.dtsi b/arch/arm/boot/dts/mediatek/mt8127.dtsi
> > index bd61ec7e70c0c..9bdf55d2da479 100644
> > --- a/arch/arm/boot/dts/mediatek/mt8127.dtsi
> > +++ b/arch/arm/boot/dts/mediatek/mt8127.dtsi
> > @@ -99,6 +99,13 @@ soc {
> >  		compatible = "simple-bus";
> >  		ranges;
> >  
> > +		watchdog: watchdog@10007000 {
> > +			compatible = "mediatek,mt8127-wdt", "mediatek,mt6589-wdt";
> > +			reg = <0 0x10007000 0 0x100>;
> > +			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
> > +			status = "disabled";
> 
> [Severity: Low]
> Is it necessary to disable this watchdog by default?
> 
> The watchdog timer is a core internal IP of the SoC that does not require
> board-specific configuration. Standard device tree practice is to omit
> status = "disabled" for internal IPs in the SoC .dtsi file.
> 
> The commit message states "disable it by default as it was not present
> initially". Will this require every board file inheriting this .dtsi to
> redundantly set status = "okay"?
> 

Moose board originally inherits mt8127.dtsi without watchdog node and I
do not have a moose board to test nor infos on the expected behavior. So 
I will keep this as is and advise on further comments.

Thanks!

-- 
Best regards,
Zakariya
