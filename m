Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191522;
	b=W+wywD0hq12tBKujq2NK5Vo7GzhKhnhMWbmAp4Hve0robUW296f5Bit2yYdu0r0ALOob
	 uJA3zEFXVzsjdqDoFB1Y2iddoxBSPk4p3W83Uf9HWHYJJoRR9zPBpr3JZHtptArwUfWl2
	 5EEITo+ffvjb6ThPM+dD+AVTmSDxFunWfu/zCec7FF4rN7befwJyAMcBoOWUv8bcmlp4f
	 7kzwv/OwQscj5uI8KSprjeuKbLSUi0/s1z3UZw2lO2TDm9o1E3K3g+GDR8406R8U6fn0y
	 ugMWmSlCfGvfBgAPqSSRJnn+WxxntBAxHS67VLNn8v3ektz4qjN2TCDifHx/RowYBGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QqTI4OK/fhuaR1GlqOO94iKxdKzeyM0Y5bQN/d17mzE=;
	b=4Dz+mAvsM0VdZXOesWf+9/2Q/9bNLlJcI63ab3Ra7ZrDxWgbnljmivYFq8S61SbdChs+
	 SgVY59rCQ5Ekh7V4by4G94uZopRXGbxymZ9U4AOTF6nFT0nUJaXhNF3QXu3EyvRqIYK1m
	 BfL1DPecQ5bAYTCrC0Q8P8cad46t0euNnUkUYBK7NDwfkMgMDTBr91FuD1VqyJw+vH5YL
	 Br5c3E1gGzSyULrkBSHXXhHwKbll/pZ1mQn59rYCpUFr5pWvfps85CtGoCG/vtnzvkkVl
	 vrqthemYW/K5wBXq5gArz8VgSuogV4rba3qkm8NjyaKOYhaliBmh38TdAGi7D22vBtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tuxon.dev;
	spf=pass smtp.mailfrom=tuxon.dev;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447B606A324
	for <linux-watchdog@vger.kernel.org>; Wed, 28 Oct 2026 12:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9447B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso8156965e9.1
        for <linux-watchdog@vger.kernel.org>; Wed, 28 Oct 2026 05:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1793191520; x=1793796320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QqTI4OK/fhuaR1GlqOO94iKxdKzeyM0Y5bQN/d17mzE=;
        b=kSmYo2IApQsaZVeoI/lHS65DndOvyRY8lt50GRCZmz/jWWH8qe4s7wo/zr2/zMpq25
         +sjQr/YIemSHfu6uSz39sV8QOjFvoudUeuFCrPfNICLHczUoyPJM2MMP2ZzljZ7g4y9C
         e2zu+Bti1OHmJlatzf5eQK5sXxZ3i0qUYaH+sDqEm4IIQ4Nk+kHHbcDLgsKMAjNiyB+/
         XHCS25+GfCpZiPYLwRPoWKFHsIs3BMbU1i6dviNOqXSCye9VVbinYsSDEBX24Qp54NKy
         2ZE+Gf+jUmLFXKEj1XKHO4ETJGGRqh51DtS3Fk31LWhkvIQvA1aIATIPsXPkaoqVeUIU
         2+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191520; x=1793796320;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QqTI4OK/fhuaR1GlqOO94iKxdKzeyM0Y5bQN/d17mzE=;
        b=K6t4dhmpuDmV8gHMa2gFbtaKx87BVOrP4vYKBbmEm3181pTWIF21BqUP83NVzckcd0
         fs/tgqsmwNI7WuW4s/WsxbngiD6BcgpJXZNNTVUnFEfVM4YJ/PW88CEldg91yb04bRue
         8Gcr8nkIJoQkq5Z/dngWuhIPJmBhRRs/Smj010Jhmy9/mDsCJzPNxhKyi0poQHiCGnqU
         ESMlQM7yGK5MsPH08uH6YmJf8E8I0KaRvGDPRcEF2Tq/p7GkEZCmGlfhsLd8Vf63evQp
         TGob+xoUqgo1TffmRz0VJBMECFZR5yLRRNBpFB33rLIiE8wSDkdZExnvqPgf3tvbrmMH
         0qUw==
X-Forwarded-Encrypted: i=1; AKwUvBzMGZ8E4qOK+w6HrlUP9xjAYo7BFJKZwJGL6xCFpoxd5vCAiFCjba4hOyATtlzzoZ2n/jlqqwD6pW+Mn/DENQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIiACQP2hTXATksIa++zkUIaeGzpgQsZ0Dg3hSCTCtMeeUKSZPE
	yu1eSIdngm9MIk80aRALUWaqQzFzsmUdtkNEeuYxgoV/j2NJpbAFMn/kQhW4/6Dt+p0=
X-Gm-Gg: AYBFou0Q/ZxkNu5sM/OpDXiLVeAFe0H0aTUlo06xSaUlKkLTOp7mrKApKAG5fGsUJ8r
	EEHL7wda/qOaKsJJ2OXq1jwElPfIaKGjwDo5A5dkAPT48NJXhW9hxtiIkI7Wvh0WGeHLFYoSXdJ
	XDE6Q2OBuL+b5NbQJQFLPDw4Q9ffhtOJx8Cihvv21HRxX7oPmoRi0hLnfkw1xFUoLBSJtQjhY32
	5hqdd63Ktc5g28I0sJOsWQqtoR/sIWf2OwfFlSW/CGcxSV/HmpJ2kRtdEb9n0HyEGxIUxsvKfej
	aB7eVujkNPGtl29qyeCjgKCeSO029dhy8LWVpBujGNAJrBYjJbjqQHgs2KzPNj8FjVuS9LPAa0n
	OJG+UZTMiak5fidgdPif+OYNvfTR9R1Qf+knpEMcxUe0JWSNEfkOGm2D32NcWEAxVS277zRCOUk
	GbOUDqlaOzzcPucuElZX/sRpUdaiZ8z3DEFxV5O4atFZbZFqxg1qnMjHFUey+5E30J5gOjoI0Uq
	G6g/k2K07DZSIyaaaTgkWA57cuzBN5oNjQIz4FtKdJLwrXmsxpTSDl8YdlvmU26rcNd5zRnnlvW
	teg9gYV1BB3MDYRmaq5u5VIaCJUXewHInsS6sQ==
X-Received: by 2002:a05:600c:3510:b0:4a4:7a8d:c436 with SMTP id 5b1f17b1804b1-4a96667dd75mr44218195e9.11.1793191519063;
        Wed, 28 Oct 2026 05:45:19 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb8d5sm29772912f8f.28.2026.10.28.05.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 05:45:17 -0700 (PDT)
Message-ID: <0602847f-4fef-49b6-a1eb-3240d7c1ecbc@tuxon.dev>
Date: Wed, 28 Oct 2026 14:45:15 +0200
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] watchdog: rzg2l_wdt: Power on the watchdog domain
 in the restart handler
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
 wim@linux-watchdog.org, linux@roeck-us.net, ulf.hansson@linaro.org,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241015164732.4085249-1-claudiu.beznea.uj@bp.renesas.com>
 <20241015164732.4085249-5-claudiu.beznea.uj@bp.renesas.com>
 <auC7FueGYTiLOpcX@black.igk.intel.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <auC7FueGYTiLOpcX@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/26 16:54, Andy Shevchenko wrote:
> On Tue, Oct 15, 2024 at 07:47:32PM +0300, Claudiu wrote:
>>
>> On RZ/G3S the watchdog can be part of a software-controlled PM domain. In
>> this case, the watchdog device need to be powered on in
>> struct watchdog_ops::restart API. This can be done though
>> pm_runtime_resume_and_get() API if the watchdog PM domain and watchdog
>> device are marked as IRQ safe. We mark the watchdog PM domain as IRQ safe
>> with GENPD_FLAG_IRQ_SAFE when the watchdog PM domain is registered and the
>> watchdog device though pm_runtime_irq_safe().
>>
>> Before commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
>> context'") pm_runtime_get_sync() was used in watchdog restart handler
>> (which is similar to pm_runtime_resume_and_get() except the later one
>> handles the runtime resume errors).
>>
>> Commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
>> context'") dropped the pm_runtime_get_sync() and replaced it with
>> clk_prepare_enable() to avoid invalid wait context due to genpd_lock()
>> in genpd_runtime_resume() being called from atomic context. But
>> clk_prepare_enable() doesn't fit for this either (as reported by
>> Ulf Hansson) as clk_prepare() can also sleep (it just not throw invalid
>> wait context warning as it is not written for this).
> 
>> Because the watchdog device is marked now as IRQ safe (though this patch)
> 
> ...which is complete hack and has to be avoided.
> 
> Can it be solved differently?

Can't tell ATM. This solution was suggested by Ulf.

> (Note, OMAP, for example, got patches in the past
> and become pm_runtime_irq_safe()-free.)

I'll look through it.

Thank you,
Claudiu

> 
>> the irq_safe_dev_in_sleep_domain() call from genpd_runtime_resume() returns
>> 1 for devices not registering an IRQ safe PM domain for watchdog (as the
>> watchdog device is IRQ safe, PM domain is not and watchdog PM domain is
>> always-on), this being the case for RZ/G3S with old device trees and
>> the rest of the SoCs that use this driver, we can now drop also the
>> clk_prepare_enable() calls in restart handler and rely on
>> pm_runtime_resume_and_get().
> 
>> Thus, drop clk_prepare_enable() and use pm_runtime_resume_and_get() in
>> watchdog restart handler.
> 

