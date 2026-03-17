Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4632DCF61
	for <linux-watchdog@vger.kernel.org>; Tue, 17 Mar 2026 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773772699; cv=none; b=dGWnMa8BWxzjAlsRY0a8yjQH239i15E2w4N04YpOeB/L9ahCYg9zpKVBrkHtF8SogNRM3cI9e8OtJ0GK+e9DTw25j3NTEMmhAfGBtLOb+VfnbB/vuxjYadhZQ2PFbVFCiPYuNRbmnmeHsav3Ba+pOJXO6eeqYLCn57XKMHJAY8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773772699; c=relaxed/simple;
	bh=fCc+/rsSp/VkyFLy/9pwes/b6WB2uRZ9EBC2AF/fc/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+VmgNBoMQaSx4QM6XIuurMYLcVOSM0eefDsqDmHQ+2GnwTsAc64JW5Di2rj8d6LiGbr4NRWP2Hak8sf/d5zfTh/LBIMdbq2kYaCH9wboppQARJRsGSQTTY2oQAn6+ELvr+6PgsAY0Zph+o6WXEn1ZrerkbHCuC9A5tYO+gjBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfLjjanD; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfLjjanD"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba895adfeaso5991914eec.0
        for <linux-watchdog@vger.kernel.org>; Tue, 17 Mar 2026 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773772697; x=1774377497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AMvE6OeOB7ElZ5FyrrBCilpB37FxtaktW1efZEZjiY0=;
        b=UfLjjanD2MDI2Jd+2//G4EN6d15WBPy+/Cxnw6m649yfTeqWcGtkpKXhU616Nre9K6
         Vx7qcQm0tctZ2kgKGLvq+esqAQriPWYBLoq17TXXLQNJhV1q3Two82MmiuCZyZ8v37bZ
         opghOtxw2+JpSSRzHttxB9t4O/n83BCjV4PYxDrFA3zlDudTttoSy9oRyHIVUbTqMUJS
         fszwVdAc+Tn4IN6KdKKmtXdXXasY7ZzsKOL28/IXwZmddHyWLKPVg9GVa0VV3Hz4ENXU
         6JX2ajygcs5HLvFYq1iwrbI4hJ+hLCBHymUflVS9PEHQIfG3xsVVzUbdj+Ta5fIhXjTi
         AHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773772697; x=1774377497;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMvE6OeOB7ElZ5FyrrBCilpB37FxtaktW1efZEZjiY0=;
        b=iw0g6GRbC2kg/d7b3fst8Pug4ljdBicUrO0GvhuSeqlrcbQwsoe0PMY8APQwJj0tiG
         9UzOi2rIJNRhzVIc/i93Ggox+wDUo4tKKzl1HoASb7rF6DO7qZ4mTlQGToOdx9AzbnqL
         NQkdEB88U+vL7HpnLCnxnQBcQgm1LaOlsGlOwmVbQUJlVV5wNNvUeLr1lpHMjDQ5GSFA
         LSXlzTo1yznLMcl/x/qD2bV59uAjGbdQajCWSPz/p/P7WwepxMfrL6p2EYVn95ZrLpFO
         HELfXxeFk3RLnBYxemtoQbWf7ZfNkutXUH6Su6ZQCCMZBWyNe0UuHff7DvGwK5fsJ5iu
         qtYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmgMAmikGWfQUXN+Mt0itAlPKaGPh8HIzawA8QPfQXMtftTAs6PGQuc2zqmt2TPv9N7fptpdT+Orhv4OXIBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaM5zb0lLCyNjPFfwCe9u+i0KAuKlyGGmatGSHdpKZOweu8Wv7
	s9OSD9CszmyT2LlGLxIbnDamBsAre0/9OOyCDijw9Xlfp8+hL8pjhRfJ
X-Gm-Gg: ATEYQzx4pLvnJ3sbAg35/+kuk7RyYejepVz3ccKCvb11CsOEsxB/geq/aUSCz74aUg8
	j8ev2rDg+RP0O/u+QMi4Av80wgYlac5np+6+JsgWIe0XUjk+Fz/SrjK10/isXvJbdeqy/+Rw1mc
	4KIR0pz07OFGwXHaNVieZuRbUewArAjbk0oGI5R7qBDn6QnT4/adxzaqDJ/In/hmYgZLBxdfX5c
	5crgp3GYMtoofXiN9xRvQIL2QSdAm3kIKOv0FlF3ZOQTMkkJ0PgzBh9ZA4a3ZnBSYkljtVHMRLD
	m42Y+kA0TDYxJKVBp8jAyC1yzjNi338s3+OSzr4LIeMDO1t4LJ/lhu10huQ3SUl4wRj4YybRF4l
	yzndKdfbVfYI/6h2dUneczq1DMd2eyxKdneKIOMV3xr/3wkYBK4jO8CSgm64PmZeXo6VOIpceXW
	fm/kHG/PnWcSct1PDw3b4J7xSX6Dp0qmlNjhCmeJ6ywvwZGQuUhYymYh385tqpzjvVOzjCz1xS
X-Received: by 2002:a05:7301:1285:b0:2be:2043:614b with SMTP id 5a478bee46e88-2c0e50dd6f7mr195794eec.18.1773772696746;
        Tue, 17 Mar 2026 11:38:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55834a0sm366430eec.14.2026.03.17.11.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 11:38:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9182740e-35b4-422a-b614-5fc57e6d2831@roeck-us.net>
Date: Tue, 17 Mar 2026 11:38:13 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Refine hpwdt message for UV platform
To: Steve Wahl <steve.wahl@hpe.com>, Craig Lamparter
 <craig.lamparter@hpe.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
 Kyle Meyer <kyle.meyer@hpe.com>, Keng-Yu Lin <keng-yu.lin@hpe.com>,
 Collins@owl.eag.rdlabs.hpecorp.net, Steve <s.collins@hpe.com>
References: <20260316214530.104344-1-steve.wahl@hpe.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260316214530.104344-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/16/26 14:45, Steve Wahl wrote:
> The watchdog hardware the hpwdt driver uses was added to the UV
> platform for UV5, but the logging mentioned by this driver was not
> added to the BIOS.  When the watchdog fires, the printed message had
> the administrators and developers looking for non-existent log files,
> and confused about whether a watchdog actually tripped.
> 
> Change the message that prints on UV platforms so it doesn't send the
> user looking for non-existent logs.
> 
> To aid in any future debugging, include all 8 bits of the NMISTAT
> register in the output, not just the two bits being used to determine
> this was "mynmi".  And provide names to the bits in NMISTAT so the
> code is easier to understand.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>   drivers/watchdog/hpwdt.c | 27 ++++++++++++++++++++++-----
>   1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index ae30e394d176..be5d8cbd0818 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -24,6 +24,7 @@
>   #include <asm/nmi.h>
>   #endif
>   #include <linux/crash_dump.h>
> +#include <asm/uv/uv.h>
>   
>   #define HPWDT_VERSION			"2.0.4"
>   #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
> @@ -158,9 +159,21 @@ static int hpwdt_set_pretimeout(struct watchdog_device *wdd, unsigned int req)
>   	return 0;
>   }
>   
> -static int hpwdt_my_nmi(void)
> +#define NMISTAT_EASR	BIT(0)
> +#define NMISTAT_EWDOG	BIT(1)
> +#define NMISTAT_RTRAP	BIT(2)
> +#define NMISTAT_DBELL	BIT(3)
> +#define NMISTAT_EMSWDG	BIT(4)
> +#define NMISTAT_GPI	BIT(5)
> +#define NMISTAT_NMIOUT	BIT(7)
> +
> +static bool hpwdt_my_nmi(u8 *nmistat)
>   {
> -	return ioread8(hpwdt_nmistat) & 0x6;
> +	u8 val = ioread8(hpwdt_nmistat);
> +
> +	if (nmistat)
> +		*nmistat = val;

What is the point of this NULL check ? The parameter is never NULL.

> +	return (val & (NMISTAT_EWDOG | NMISTAT_RTRAP)) != 0;

I am not sure if it adds any value to do this check here instead of just
returning nmistat and checking in the calling code. Seems to me this just
adds unnecessary complexity to the code.

Guenter

>   }
>   
>   /*
> @@ -168,14 +181,18 @@ static int hpwdt_my_nmi(void)
>    */
>   static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>   {
> -	unsigned int mynmi = hpwdt_my_nmi();
> -	static char panic_msg[] =
> +	u8 nmistat;
> +	bool mynmi = hpwdt_my_nmi(&nmistat);
> +	static char panic_msg_default[] =
>   		"00: An NMI occurred. Depending on your system the reason "
>   		"for the NMI is logged in any one of the following resources:\n"
>   		"1. Integrated Management Log (IML)\n"
>   		"2. OA Syslog\n"
>   		"3. OA Forward Progress Log\n"
>   		"4. iLO Event Log";
> +	static char panic_msg_uv[] =
> +		"00: A watchdog NMI occurred.";
> +	char *panic_msg = is_uv_system() ? panic_msg_uv : panic_msg_default;
>   
>   	if (ulReason == NMI_UNKNOWN && !mynmi)
>   		return NMI_DONE;
> @@ -189,7 +206,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>   		hpwdt_ping_ticks(SECS_TO_TICKS(val));
>   	}
>   
> -	hex_byte_pack(panic_msg, mynmi);
> +	hex_byte_pack(panic_msg, nmistat);
>   	nmi_panic(regs, panic_msg);
>   
>   	return NMI_HANDLED;

