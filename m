Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9925EF87
	for <linux-watchdog@vger.kernel.org>; Fri, 21 Aug 2026 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787273987; cv=none; b=ZSd92PHt4F4D3xGWMOmgp7lk9f5twtludZq3/RD4nOunwFNORN2rWSMyLkhAo65zwLAuC+Lpm5LhPTGDp7swW23B/VbZJm7J98MtgWhhn1Wcvslg5wINrxkX+ssS/ra4z6WXmwrtI2pZBScfFihsuXMvXZu1N+WUMHo3Sr/vihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787273987; c=relaxed/simple;
	bh=K6FXpvA9d0I8igTog7ntPon++21mKCAVjx3GG0qZiHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JagEg8vM/w5XGhH6K/Fm6rxqY7uTXifiSk6OO0fbz3frJeVmqkM5dRwTZjhpwoBGwiE7jScckZEw2Y1bMihUlRsaSNMFsrGg4313Z0P2veAm/LVV0ThH1E6OvA37OqyWgY447DtfQQERm5GkmNHelCcRwtQ30OKM+eWjbEBGknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oiqZ3SGB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiqZ3SGB"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccf2360620so4017905ad.3
        for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 17:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787273985; x=1787878785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=haJCnuG98e0n1VLIbY6tb+ggrITBMJjjGu/nAQ06pNg=;
        b=oiqZ3SGBzuXxy1EE2tBtR2yus7Fr3Z97QsnHi51LY9FBixO2CS61Pk38NtnImSCScg
         wrm3JN8JyvphAWyJJVX8x8vQyJcaIy5TW2pjQMYPR7BaqJwxJY/7NZcBoWkNFKiRlF3U
         2M435iyKcaQjVQB3QItcUZj+zoVI2SyIH+1XMbmxvfntqWhSTjZMBHyIGt1IEomff+/y
         kbhxkh9FSJKzXlSKZaAPqwe51vIKxFnfPeBJ8vhtzptD2wmGj2EwqbePxHvv0bPMyce+
         Bkd8oWOs6j5OE2RXfEPxgsjw7D9ICVYtgvtUkJIr4r+Hb7wRGMKr5Z5pcOI14YtSc9mN
         uZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787273985; x=1787878785;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=haJCnuG98e0n1VLIbY6tb+ggrITBMJjjGu/nAQ06pNg=;
        b=Yh6hCuJlLn8Tij+mVzaETSiI7b0foOI7DP9lKh3rRQAEWzVCgrJ6FMEUvVoU7lIZWr
         Jf8tttl0eqIEf2/rYrmnsEkYVAJqqJXeIfZBQE95UgCJggXl91SE5pODllLBHolfxDo0
         6KZrp12TsoGup7Du3LUjjIq0dkQBmpiQmw38FZS1JkwRyWur38BqkWNB8ThTnK0WH1Rb
         SVbJkh570mea/glzYcO6XF1F0Jmq2ZQMdw8QJm1opJmDh3nNfzSOtflh43nviLlIJwdt
         l4ZQVZI1duRU7swGus9A0Q0cTxOZoT9JMP+AMpdMh3dGyKhzcu3JdeNNQTPotYrqrOoN
         tFfg==
X-Gm-Message-State: AFuF++kxNvWE3WOxxtdbeC4MmbDO89lH+Iy0xX1l7/YZC81fhUNeGRXI
	nKVqPNMPyCsKkDWugz2NMzL4hIuaQTobVDoVhGLs4kact1Q4K4pETqTH
X-Gm-Gg: AR+sD12OB7+/5TbRMOvW84e1byGYfjAAIoynlLuuu6v4pFdAnzcvXjUj6fgxRChcgOY
	8GQtHBVb4UKoKsJgJUmJmfhKtL8Jp6lxWXR2t5Gxm6e55nBYBm0wyH5KSU5gQzaXOVc7MHW2nb9
	UsZJJpIhr3CT/xwSgxDfPKaFtbPkcaAA/mb7hMWSNk3P424JoYxgoDpjWSvTg7HXhW0FLX0TNPa
	xpWQ0X7kQ3JCh0YR9ai0E6jYgUigQdWWaI0isNBBPKLGwwk4E7WCGwL5V+yCSWtfgATLQlXkgZu
	vjAGq/LLLEdhAetueeAKpnPIu0yrBm6Kin2jiBSFIVDg1aYGtIZr7XMNGsTGhrCVfzCjeuAT7gN
	/45sV1u+rI/R/nDEbUJKU0EhNlkMUGDSdR8UYjUui9LzdFCij5CMOwqRDUxhAbCLeErEibouuuE
	AveGArji0SVdhwTBjqxmBCbbqtWYPJdDmXmKArepFUvjIoJ8Jgo/4nbtQAWR8Ln1uiF9hvWxYRe
	YyeFBIzCoyD23kqIBnto0aGNhxltorVDRcVbA==
X-Received: by 2002:a17:902:ce08:b0:2c2:62ee:5a0d with SMTP id d9443c01a7336-2d64b14fe10mr47484475ad.14.1787273984882;
        Thu, 20 Aug 2026 17:59:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327cb5a9831sm13921074eec.21.2026.08.20.17.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 17:59:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <22315f2c-5434-4361-9ec3-d8c256cdf50e@roeck-us.net>
Date: Thu, 20 Aug 2026 17:59:43 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: sp5100_tco: add reversible legacy MMIO
 relocation
To: Christoph Berliner <caberliner@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260820222541.16494-1-caberliner@gmail.com>
 <20260820231409.8427-1-caberliner@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260820231409.8427-1-caberliner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 16:14, Christoph Berliner wrote:
> Older SP5100/SB7x0 systems may provide a watchdog MMIO base that
> overlaps another reserved resource. On the tested system firmware
> programs the watchdog at 0xfec000f0, which falls inside the IOAPIC
> resource and causes sp5100_tco to fail probing with -EBUSY.
> 
> A relocation mechanism for this class of conflict was introduced by
> commit 740fbddf5c3f ("watchdog: sp5100_tco: Add SB8x0 chipset support")
> for Linux 3.8.
> 
> It was deliberately removed shortly afterwards by commit 18e4321276fc
> ("watchdog: sp5100_tco: Remove code that may cause a boot failure")
> after an SB700 machine failed to load BIOS after running a kernel
> containing the relocation path until power was completely removed.
> 
> The exact cause of that failure is not documented. One relevant
> difference is that the old relocation path reprogrammed the watchdog
> base but did not restore the firmware-programmed PM register state when
> the driver was removed.
> 
> Add a reversible relocation path for the legacy SP5100 register layout.
> 
> When the firmware-provided watchdog address cannot be reserved, search a
> bounded 4 KiB range above it for a free, naturally aligned 8-byte MMIO
> window. Use devm_request_mem_region() for each candidate so resource-tree
> traversal, conflict checking and IORESOURCE_BUSY registration are handled
> by the resource core under its lock.
> 
> Before reprogramming the watchdog, save the original PM control and base
> registers as well as the PCI watchdog decode register. Disable PCI MMIO
> decode and the watchdog timer before changing the byte-wise base
> registers, avoiding transient decoded addresses while BASE0..3 are being
> updated.
> 
> Restore the original firmware PM and PCI state on probe failure or device
> removal and release the relocated MMIO resource through devres.
> 
> On the tested system the complete load/unload lifecycle is:
> 
>    firmware:  0xfec000f0, PM control 0x03
>    relocated: 0xfec00400, PM control 0x06
>    restored:  0xfec000f0, PM control 0x03
> 
> The relocated range appears as an exclusive SP5100 TCO resource in
> /proc/iomem, /dev/watchdog0 registers successfully, and unloading the
> module restores the original firmware state and removes the resource.
> 
> A warm reboot with the relocated watchdog loaded was also tested
> successfully; the machine booted normally and the firmware watchdog state
> after reboot was again 0xfec000f0 with PM control 0x03.
> 
> Tested on Linux 7.1.8 with an AMD SBx00 SMBus controller
> (PCI 1002:4385, revision 0x3c). The sp5100_tco.c driver in current
> mainline is identical to the tested 7.1.8 version.
> 
> Signed-off-by: Christoph Berliner <caberliner@gmail.com>

Your solution is way too risky. Try to find one that lets the driver use the
region without reserving it, specifically suited for the system affected
by the problem. You should be able to identify that system using DMI.

Thanks,
Guenter

