Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460030;
	b=Bow/7qNb535IcZVfiEUmeguMyWxvLP4yTWKLnJFlPs+mrFn52ST6GKi13hMlubM9P9Ld
	 dT+wrUz/AfQpTBTVX8boutRYkBj1FtMBiUsUjnkM2C3Nrb816aWFGD1bM9pAtvgNat/jb
	 8skvoaSmc584QIJ5IhKeiE+qh16O+Xv1Sj730Q887JcEondTpuEbUhmI+vjJ94V0zfE1+
	 B5iiyCPN55PPsReboVkUKA1eHmDMx6XXUyngLeOYg/qK3f7ddUjzepu9j7SP97bLx12Fg
	 yWVxtdqmfjngzkA8kKw52jPE6BW0tCMAoBhOv0wVv9uYLctRKAiKzsssyF87eex/ILg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/qjMCagPo43beTdZpO9fjGOooFBNKI+5JsBjceANaBQ=;
	b=aIfG4LVjhz8NRjVUsJTvTMiHF4Qn4rF0qclenj19R9COvjAL10AkrYYHQsI1aFDXtkHl
	 QwWrv+o0hF28ZJm6DK9WhsedfB80MnJC43Zf6fVBuMAtiwyCZ54iidtrHbkwipLaJtD6p
	 o1HKB2v1xWbuTs7S5zgK9mRXmlUUH1AAYo1IIlRjbWEJ5t6phxjQtbjxuRSCIA3sgR+7p
	 Dot6rVH/FvGyE7v0URDzmzqHNz+wEg0kizUI9IUZBfCdWyxsy4RXkue2fCm0EVIGKrDDe
	 TalXrsGFgGnRe3SIprgUWENdzYf24ePMhVtWNqVFVgchE9iaQraHtxXvrVPeMb0j1nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GdYA2Nse;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97819606A319
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97819606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GdYA2Nse
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15dd124bbe7so5061935c88.1
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460029; x=1793064829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/qjMCagPo43beTdZpO9fjGOooFBNKI+5JsBjceANaBQ=;
        b=GdYA2NsecA2pryT7aTG8nFth7vLhIeg1iPc8A+eufB/L9s2B7hSq5t8X8QTeJrIH2W
         Mcmu+Qt1Pf6B49l+uhl8xnw2FjXRqpIxzXtmQSvnsRXqKzy4sWt9tkXKY0uc77ZB17v+
         3OFRHfNAsLm+JHv18LvCtI00zcSt36854uJhbCsU5PVFflx0AqlQfkWByiMQBCk8NMCK
         e+8hNpVcpHM5E+i3kL8ESov9UuGtGjpUmRtCZsJh4tpWlHrKq/Iu+MysHnC4aE0nZX1I
         5Dgmsh+5yBNG4H0akmF4j/QWGmWIzVgTPVFmb6me3hOd5X0Y6Gzaz8GLxer3XssW9sl8
         osFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460029; x=1793064829;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qjMCagPo43beTdZpO9fjGOooFBNKI+5JsBjceANaBQ=;
        b=jZw1S7VUH07eKifutX7BX3NgQV1WLqQd8C8I+T3HwAQhUfub7eKwPjhGsXwCiv4rfH
         bEPxM179jFJA305OD3FX8hJGh0zK2gzRCIcAFDfEYi+Zi/LmLX74Qxngi0aHuU0NDQo1
         uSwTTXeKk5W4jbKLm86pwZiXSxpYiwxXZeBsyp+8ER5xPlPoOnCWHosWmKDUDREdcGbM
         Pgt+jFJstqmz0A7fH+3VP8afnjD1unyMOsVZDgeMIXXtV8ivqsgXH80Gy9gIxfI0oECN
         p7yacO2AgMcSnEWtz/f3YniQCqstuUzhdYnrDjBoeZhuEPi3+2sBziY6i4SsK0mdG+GP
         1FYw==
X-Forwarded-Encrypted: i=1; AKwUvBwBgeTTwmm0GnVjXI0SHUHMYZTEVniz5Bi3gMKZtxdR3pWzfA6cX9XszMuo4wLOwDBO2bVZ5X7oA8IstbZ1cA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKBkqJXArIkMzLORPqZL+4LUaasCH8OdPNnNdmnO1lExaS10IYh
	1cq2551hZnAqnG//lQdqD0A52opV2E3dcyv9C5YsVzsjmhP7Gnp8njXt
X-Gm-Gg: AYBFou1BXtI29ww+KbeM0hWs8ce7vrsrqIiLry8NDfPcnwZ6RvcAwN7IBzxRfq1fzzi
	TXJDBMdkolUmB6WfHA69Q2ZFFhFOevPA/5uE4gIdW5bBaWK3RPyaWEniGU5UtUhEih11zOkoQMl
	AQUG8Qc407PLhgRq9fMobupxFCEvk9zxDxDoFml7jXOibLuP/5xpIL3mZ7ZwS4q1w6trb5/EBbX
	iPUBIUfpiI0L0JTG0H7H5SvtOWmN0tod6FHXiFrFYM4nSkZvRqln02iYQl7nt2jZgtW1voOGfHV
	U99hWmaqrYobWhwVPXSVb0/p76IgB0XyplUOIzpSMtjh3HtCI0SIJmLEkHtc7mWKB5EJW0xGPtY
	m9kNHgcz9x1vHiqE3NpxBmQOhAnjL+xUgwNbbVU6ZMR+eXU/ay59KHYBuGs/UwiU4rlu4ZF5FYA
	lHYKIPi9A52gaflIXft69KUSnUxJDL8MaR/ywcaS0i1ULlfLoYnHdhjJt0OC2gHVBRzIFsWZb67
	O51VGdkty44
X-Received: by 2002:a05:7023:d0b:b0:186:4a57:94e5 with SMTP id a92af1059eb24-1864a5796e5mr13543435c88.34.1792460028740;
        Mon, 19 Oct 2026 18:33:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c5cb39esm33881194c88.22.2026.10.19.18.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:33:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:33:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Igor Velkov <iav@iav.lv>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: orion_wdt: load the pretimeout counter
 on Armada 370/XP start
Message-ID: <8f2bfa5c-0e53-4a84-b6bb-795c2c4e1475@roeck-us.net>
References: <20261012-orion-wdt-suspend-v2-0-f13cf71443ba@iav.lv>
 <20261012-orion-wdt-suspend-v2-1-f13cf71443ba@iav.lv>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-orion-wdt-suspend-v2-1-f13cf71443ba@iav.lv>

On Mon, Oct 12, 2026 at 03:46:56AM +0300, Igor Velkov wrote:
> From: Igor Velkov <iav@iav.lv>
> 
> armada370_start() enables TIMER1 for the pretimeout but, unlike
> armada375_start(), does not load its counter, so TIMER1 runs down from
> whatever value it holds and the pretimeout can fire early. Of the boards
> that use armada370_start(), only Armada XP and 98DX3236 describe the
> pretimeout interrupt in their device tree.
> 
> Load TIMER1 on start the same way armada375_start() does.
> 
> Fixes: 7a6b3d8a432d ("watchdog: orion_wdt: support pretimeout on Armada-XP")
> Link: https://sashiko.dev/#/patchset/20261012-orion-wdt-suspend-v1-1-1676cb79e29e@iav.lv?part=1
> Assisted-by: LLM
> Signed-off-by: Igor Velkov <iav@iav.lv>

Applied.

Thanks,
Guenter
