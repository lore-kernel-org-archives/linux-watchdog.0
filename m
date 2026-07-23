Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B59D2D5A19
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844204; cv=none; b=soRQpOh5Uo6KNtPIhf//ADOC5V82y4gUp1if8MvlaFUboPqdeJkJ7MAM7uma0GuZnVXOl2GgemmK4ctRSAjzOYR7YG9OCtyw5M10gNWQckcp0CJ+7L7xY7oO7NLohfqhNkfRovjfNKamErNHFVijgXogdjZ53oUVY8UHGqhFin4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844204; c=relaxed/simple;
	bh=kRsK/Rdmm4Pm9VALbcbsBbcsqFdE1k2tQjHCHH4mgqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pQ4NxP7fBAILSlIbaR0MbxAWtYb9f7Yzn747DGqKlhcP+zbN05M/5YFKLUAzYsPkpwI+yNAX28ct/Wljr3SbPtTt0CYGO/XUgeD/Z7UMaO5BS9a/PnETdU8t2ISCo+cshi0cTqsNJNB/PxcjsFCq+xffomG0SOwP99Vsgh3cr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io/wGogB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io/wGogB"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84a652535dcso742532b3a.3
        for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784844202; x=1785449002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D49XJVrQTmcvUOSHcXSF7i5rCDIKfDnqsHggFkXm+zU=;
        b=Io/wGogBNg62gFVNHbWxaClXnNCECKbHKJf4au7iszEW/MQbf98h+QeEhStS2Qi3Ka
         wpVQMM5UwOIRWPSQf2qukcYwi/V/XdTr8q2pkjmJnwwV0rvFccfruv2VXmjh0jbbwHyc
         SBwuQ9o59HzgdHJYOr7axoKNt87i66HXBuA9PsM2yhOvuxOgQN98NNrtyQK3/SCzQ0rQ
         gBStUS9c+xCPDCcvRaxE7PQrQNyVBCGd27kM0EyKeYR1OvaVkBHYwbCJSZK7G4JKE+/M
         eMM4LBTx5EA0lrAkGHYMvjcp1q0RUAouqdTakyEvBSUoqHrhRrfWnbKPfk7xVcYamGlT
         WTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784844202; x=1785449002;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D49XJVrQTmcvUOSHcXSF7i5rCDIKfDnqsHggFkXm+zU=;
        b=RZ3Gq4N5hJzNxl/zaRpJFwCVj9A8FGc6aDF8gJkydk3cGIZvARyUwWlKzk1WwmpqWp
         iH45tl83OB650KLFq+LBVxoN16N0uuzewZdl+Icks7EkP+n+N1Hi7thSKuxG6c7cOnMx
         qPNlVDUkmffxr1AxlRPdywjIl7K9Rd5Souen0glfQWL1JozLW8JbBuQv/ffrZ2MkAp4b
         SDWal+OIa2o9H+opjsweshpRzL/nv2A3jupQhWZuxoNztf27TcFYXA8T3VK5avFClvKN
         KdDFvYVZaYBfIrDJM/zcIsa93Q9LaZ+yIEMxIO+D508cLcR1QJhNTDuqSUANdK12XXWH
         3kjQ==
X-Forwarded-Encrypted: i=1; AHgh+RqhlTa0Qavoy24bKN8qApG2PUXjtp46t2lY/tAJaeYNYdYTaRrCFq1R98yfUKhIjnmjNA6PairvfpOtKgLtfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3AlcTyalqF/g8svTYvDvY/xJBErL0rhLUC+5LGIGyofxdtOR
	jm/H8FL5OoS7b94u8o6s/UHJLN2/oWStRUxrttFQC2SP1WE0+QouYImW
X-Gm-Gg: AR+sD13occqldUCWSa5V7o2IagVBUfpXjZkfO9/igI3aFLfOiSrOUqGKOO2JcGdk0zP
	CJ3CwN/hLIhqGQyFkS+mk0BjvhVkn+4BsjdFZISz6BOVqftb6O78OWPsKSCjI0zNfrseGSllywW
	ZMZYdvCFE9tH1wkLlPPKkjd+fkfP9ugcx4qoo2Oy14pubk1tUDZCER1sUo0g6tZBMSuY6ZVZZEx
	QHCjf3MTYv0EMDPlZiRpBgbAckhcMtqtTQzovpUyymd31UBLtu6xpYVHDps5sm2UkJXESdDFLcU
	p4LjMCI2PFJQ6X4nElky0NSL3KmZrA7TGjYuG6xs/DHvhkNa2o5kUAM7ZON/L05aA/eOYamlQmr
	QkYJpi6uOKJrO586PwrPuwYVemYDzW/myaCNfMtPVNeZXAOKEt2m3eltIxGlVM1HY3lA6D553hK
	t0XsJNB79pPetXgj2aqyuFyBC3Z3jfpquFMD2CheTF9GD3jI19kwU=
X-Received: by 2002:a05:6a00:10cd:b0:845:d286:1fac with SMTP id d2e1a72fcca58-84e2bbf64efmr5108692b3a.59.1784844202517;
        Thu, 23 Jul 2026 15:03:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17262e33sm3746020b3a.14.2026.07.23.15.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 15:03:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6b81d914-7d29-4818-a1c1-748dff7e9319@roeck-us.net>
Date: Thu, 23 Jul 2026 15:03:20 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] watchdog: Remove redundant error messages on IRQ
 request failure
To: Pan Chuang <panchuang@vivo.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Andy Shevchenko
 <andy@kernel.org>, Sander Vanheule <sander@svanheule.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>
References: <20260722084218.79073-1-panchuang@vivo.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260722084218.79073-1-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 01:42, Pan Chuang wrote:
> Commit
> 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()")
> added automatic error logging to devm_request_threaded_irq() and
> devm_request_any_context_irq() via the new devm_request_result() helper,
> which prints device name, IRQ number, handler functions, and error code
> on failure.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this
> automatic logging.
> 
> Remove the now-redundant dev_err() and dev_err_probe() calls
> in watchdog drivers that follow these devm_request_*_irq()
> functions, as the core now provides more detailed diagnostic
> information on failure.
> 

Series applied.

Thanks,
Guenter

