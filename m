Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066AB3ACA65
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333152; cv=none; b=g2o+XbDRgAWxtwEvHNQ6RlnMeR8SqMPnHk5JNCTEDvSc9Gm7l/0RJrWs+WFdGs8sRK8ltvaTHiLIgOrIgbdp6GzBbr5k/bhun1TdUwqvzMt94pr9LBOEclLLS2ug6PIOBzHUk49s8YVWzkxwLszosjpYkuZ253o7P49DMvK9tzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333152; c=relaxed/simple;
	bh=u/28t5pl9eo6hf6+xfNzC4/X2BvENb6Oxp1IGL+chHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wk/QP0qnbDioLGG+vUNXY6UVGOh5vB7d4GCHiQlYHH+7t4EAmPUa1aTh60U/q+JQd80Cprfr5k7ol7885WbuZbPvXeUw6TSM+uFCVU2Tcj+MNy7+HtkgDehp/rcWA7lY7OwZUGa59kzjcrP26BorT1VI9BfvkZk2nwzOMMbf7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bfVBoMg4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bfVBoMg4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9145A1A0E87
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:19:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6002E601A2;
	Mon,  6 Jul 2026 10:19:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77B5811BB9EF0;
	Mon,  6 Jul 2026 12:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783333148; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=WYIc7Tsbtyzr5DKlHOn64hSBw0UDKluxvaNCATOv0u0=;
	b=bfVBoMg4SNNEZ496nvOjyAumnNgsI65qtdc6pEZDwN+xs6CZ/pNQLeIorFIJnzk3BZbOKw
	Y+6w4gOS4gYOXbC6peZywq04GY4MuI4ExYC/+UMUfdn5xbFvOnjVTfU5GoY/iJnfQ9jwew
	3EOJ++7yGvN5+camZ5dIoIbXATYZslqCcCxNF8SA149ZYvki14b1PtS+Dv89cst6vuNk1V
	B36CwNSmOr4w5Io5SF+tlCxtIr6+XBmIkSBT+iaZpWped8JZC57pQwJ1FVumHIBNHduNio
	iZoQ6EUL04wRduVRkWmaxdlnw8EvVa5fEv1Jej9N8H+caccgZkSGbRLr/iJ68g==
Message-ID: <ed94ae85-4b85-46a9-8e8f-3db370b4dd98@bootlin.com>
Date: Mon, 6 Jul 2026 12:19:06 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] watchdog: w83627hf_wdt: Add NCT6126 support and
 improve handling of running watchdog
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260706-w83627hf_wdt-nct6126d-v1-0-c5b0d51691c6@bootlin.com>
Content-Language: en-US
From: Paul Louvel <paul.louvel@bootlin.com>
In-Reply-To: <20260706-w83627hf_wdt-nct6126d-v1-0-c5b0d51691c6@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

The first patch contains a small mistake.
Please discard this series and wait for V2, I will send it immediately.
Sorry for the inconvenience.

Paul.

On 7/6/26 12:14 PM, Paul Louvel wrote:
> This series brings two small improvements to the w83627hf_wdt driver.
>
> The first patch adds support for the Nuvoton NCT6126 Super I/O chip. The
> NCT6126 is compatible with the existing driver but requires reading the
> full 16-bit chip ID, as it shares its high-byte ID with the NCT6116.
>
> The second patch improves the handling of watchdogs that are already
> running when the driver probes. Instead of issuing a single keepalive
> using the default timeout, it relies on the watchdog core's
> WDOG_HW_RUNNING support to automatically maintain the watchdog until
> userspace opens the device.
>
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> ---
> Paul Louvel (2):
>        watchdog: w83627hf_wdt: Add support for Nuvoton NCT6126
>        watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boot
>
>   drivers/watchdog/w83627hf_wdt.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> ---
> base-commit: 028ef9c96e96197026887c0f092424679298aae8
> change-id: 20260705-w83627hf_wdt-nct6126d-9a016bf7c936
>
> Best regards,
> --
> Paul Louvel, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
-- 
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

