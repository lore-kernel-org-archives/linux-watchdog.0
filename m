Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A1634104B;
	Mon,  8 Jun 2026 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951137; cv=none; b=kPDt+G6/iJeUUo31aWVZn4zQOd6aEgsYy8mi6tm9RIz6xMpu/pgCsJFm4201q44nXFg8OSeOOtGBdLU2EK+0Vo2iEof8EdxFbAFStnSoa4iIupEPRo7llU4VtbBVuGC6d+SoayA1+5K0y8pE5dC6O9uVdn9FGDzQ1JsFs2Lbl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951137; c=relaxed/simple;
	bh=hTL8ZR3VPVw9YEegIP5cAxrbCCtByYq2SVKt2Kx7Y0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PxD+OeUs62qS/q40o1uQi8aYcfNZlg97H9aj2q0FAXUdBDBAPIuJQfTnLG52SmQgUBpwaD2Jd04dgJEkgnO3gmSmiPvchbEMf/fGmRC3Sx8/ToH06nJpLMqlrIXoIlihSE1snOrwYGlH1uOk8WmK3VBJmJnmEiYLGOjPssifMME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=U4Yi6lMz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="U4Yi6lMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1780951137; x=1812487137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hTL8ZR3VPVw9YEegIP5cAxrbCCtByYq2SVKt2Kx7Y0c=;
  b=U4Yi6lMzzkRQI3I3h/Fa6FvKOD0dUTTNofn1wsBEKgE+AcJAjSX+O6BX
   dEofstsXDFAdUDL0jIS3DZgthhB8ZuCwja845aGcYkFzNcuL14byQRHdd
   v4PiS8YtOi1mdJC23Ve4TDIUOGTKmrsgf4fpKwJ6ZBDRrwz5dLuzLZ9hD
   0DJSHFIk6wBvgH/G3ncvz2Dws8xeF+kewukWEEDk/qyHHYcmeKMvHrO8I
   SqRdzlgZHOK4u9LqBMbNSfwk9UOG69MeBF4H1hNW2rJnsnnDpryhnkH/J
   zQ3+68qC+j5oj2Ah7SUsy8IjJu+sXsZH1mFzh/4Cb6d2zf9PtQACTX5r0
   A==;
X-CSE-ConnectionGUID: WN7Jf+4cRveid0SHWkkRyg==
X-CSE-MsgGUID: J1tZQ2cKTqm51WcorA2RzQ==
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="290168080"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2026 13:38:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 8 Jun 2026 13:38:49 -0700
Received: from [10.10.177.23] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 8 Jun 2026 13:38:49 -0700
Message-ID: <10b595d3-d44b-4fbb-a834-a94b154a0381@microchip.com>
Date: Mon, 8 Jun 2026 13:38:46 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/3] watchdog: sama5d4: fix IRQ and timeout bugs, use
 platform_get_irq_optional
To: Rosen Penev <rosenp@gmail.com>, <linux-watchdog@vger.kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, "moderated list:ARM/Microchip (AT91) SoC
 support" <linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20260608200933.18669-1-rosenp@gmail.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20260608200933.18669-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 08/06/2026 at 13:09, Rosen Penev wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> This series fixes three issues in the sama5d4 watchdog driver:
> 
> Patch 1: Return IRQ_NONE when the status register indicates no watchdog
> interrupt is pending, and pass the configured timeout (not the hardcoded
> default) to sama5d4_wdt_init().
> 
> Patch 2: Replace irq_of_parse_and_map() with platform_get_irq_optional()
> for simpler error handling and EPROBE_DEFER support.
> 
> Patch 3: Move platform_set_drvdata() before devm_request_irq() to prevent
> a NULL pointer dereference in the interrupt handler if the shared System
> IRQ fires immediately after registration.
> 
> v2: address sashiko review

Rosen,

I'd like to hear how these issues where found and how the patches were 
tested.

Best regards,
   Nicolas

> Rosen Penev (3):
>    watchdog: sama5d4: fix shared IRQ and hardcoded timeout issues
>    watchdog: sama5d4: use platform_get_irq_optional()
>    watchdog: sama5d4: fix NULL deref in irq handler
> 
>   drivers/watchdog/sama5d4_wdt.c | 32 +++++++++++++++++---------------
>   1 file changed, 17 insertions(+), 15 deletions(-)
> 
> --
> 2.54.0
> 

