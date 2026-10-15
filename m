Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784D44766AC
	for <linux-watchdog@vger.kernel.org>; Thu, 15 Oct 2026 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092636; cv=none; b=Cfru7k7v0YqIRwteTTiXp6X5rjsTHwZ8xH6/IzSNAL3NSEplecnsEuPnfMY58uW/GTKZW+IkW22E2ywLdHtOR5xfkjf1AGbkzZVIxWKM2HRd4IZb/Os1iHXgjRSYqXbiwXcRv2lOD4OfZes9HdRvPhAjAc4M15h0nE0QkbkbhcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092636; c=relaxed/simple;
	bh=9Kqk0Q0biXFoJEttgW4MNrGZoQja7yIbQAHZST2gk7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5WfQsV/OiVrZ7E+ecn7chxSzKVpqTPxGu09pGd7b9x2UlGT1D8bbbhdbanq1cUkX3ec//GTHQd8SUZt5dY7sWxHS8YXVpE2YLQVI2aanSa656cFDU1EcyuSPVKfGGywLCDUdJ48J/5TgyRpDypAVJBfxpuNpUqzBPaY/RQ3ItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h0TxixzX; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h0TxixzX"
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-93cb1c0e851so437865585a.0
        for <linux-watchdog@vger.kernel.org>; Thu, 15 Oct 2026 12:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792092633; x=1792697433;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vb16iMhx//XGUDWs4+DiLxrnqFHAghGxCusgzIfyjf4=;
        b=LVwiIGXH9V40sJixo2ZWLgzQfmJZ4sv/Z2kSqVZxy/jC4z0FBcS1hhn773ro6UNjEw
         CQJLOQJA4WBiKOVQqqigEovXrdnflLBFiFDNHE2BqwzhDJkIztYXaitjfYeafIm9NkXH
         gCNHauqmo83W3PDU0WJJH5+bKWjJ66CCb52Qu+Ur32j6UH9DXLwqH2XE3Z4bbkv1AyI8
         82ib0nR08ZmHT1s+nMEkcKeoo+vyW4uA603+AvOQgZHvgrhbINej4q4pK5w8126NuC6K
         +2QRanwWb4+0iuZzpili0HHcrOoj4XK9FeRtSuERR8u1JcEuLy6I2r41wYra40H6WDcS
         GsYg==
X-Gm-Message-State: AFq9FYLozpNSuV480IOYUvi9Pp3c9ciMm0Rr8BgScYFIKPtovuO/+v+Q
	tsrKDblQRkytzAMu1JcYE3oh8mrubNolUjttVRyEuoCnvSIThH8hisPjQLhA3gWhVhS2zH+FZj5
	P0Y7pr/KpGB66IqSaR6MYGYf7AIAVMaNod1tL16YjJwbhu4N2o4ipRlzxeTLeBqzFuz5ks8z1zL
	Z3Q0Nqloh8yNEtcKzZ2WdbWYlgyZeZqdCQAizno0SVeB+gw3ie3Sb5iMT3JLKKuNtrJJ3ftHiWG
	kfKov7axGvhvs0CQO0C
X-Gm-Gg: AYBFou19jD07RKnAidiuriddrIcTI03z3bWaiBW4eqkiWlvNWApOZP5j3r4ZTyOit7M
	7KJK7jlPjQCgbJFkmhrVT7NFphchuLJbntnN091E1GizbpiK0FgQHnEKdV4c/VHRQFecTNvFeUx
	DbDTCwdoFf/6Ogh/ZW3uGmb+vOjY4g34mOIyStf03MAvx3yLAHB5S2BR1pvmOSiOwzdxTh8k+P+
	yfhUlWsBE7oMpYLlIyELO2zShc6eVoTqy0o1dmZRSE2GSyvcISLtZLgQhNkNNETs1soWQATNsmC
	N4QFmg75wIQm9KI0U+8oY5ErfW1vXtC8LXloqL2tVVb4SjJbK7/p57jaloBvvD9+BKzBlwM8Amy
	sgC5CqXE5y9HTFcmPgrJawoCAw/6IXDsE0QcUhpc1k6E8nuiDRzKK72+MXhnm/krHAZ1j4wxnAK
	1ZNddMkebTpztOAb7UuPx3OEAzA2YIGv0Xpk+r
X-Received: by 2002:a05:620a:470b:b0:93c:29b3:3525 with SMTP id af79cd13be357-93ebd262b17mr3120241185a.36.1792092632900;
        Thu, 15 Oct 2026 12:30:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93f19f527c7sm3670385a.0.2026.10.15.12.30.32
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 12:30:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5350ec54bf6so115049171cf.2
        for <linux-watchdog@vger.kernel.org>; Thu, 15 Oct 2026 12:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792092632; x=1792697432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vb16iMhx//XGUDWs4+DiLxrnqFHAghGxCusgzIfyjf4=;
        b=h0TxixzXOhpavbrQmxsyLNTkCupmOvPNxdUKqC0FAhLgCEBDocLOJ89vl0ZluS2VkY
         2XgaH2gZ2IgWs9luM6Jbh5ttiUAkNWHsEW0HgPlWvM0wk7dn2/626UsKpMMWZn4X1R0K
         JmC1nz13lPs3tNRVLHoIbpDHeUTbzIsLp29s4=
X-Received: by 2002:a05:622a:449:b0:535:92a6:22dd with SMTP id d75a77b69052e-5359fb12660mr349334341cf.41.1792092632039;
        Thu, 15 Oct 2026 12:30:32 -0700 (PDT)
X-Received: by 2002:a05:622a:449:b0:535:92a6:22dd with SMTP id d75a77b69052e-5359fb12660mr349333611cf.41.1792092631350;
        Thu, 15 Oct 2026 12:30:31 -0700 (PDT)
Received: from [10.14.194.119] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a74c0bcsm1742631cf.1.2026.10.15.12.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 12:30:29 -0700 (PDT)
Message-ID: <1a3b094f-94b3-4932-990d-dd717b189d69@broadcom.com>
Date: Thu, 15 Oct 2026 12:30:27 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: bcm7038: Add a restart callback
To: Linus Walleij <linusw@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-watchdog@vger.kernel.org
References: <20261015-genexis-xg6846-watchdog-reset-v1-1-9577d65223d5@kernel.org>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20261015-genexis-xg6846-watchdog-reset-v1-1-9577d65223d5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/14/26 3:39 PM, 'Linus Walleij' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> The watchdog in BCM6846 can reset the system, but bcm7038_wdt
> does not provide a restart callback. Add this.
> 
> The vendor kernel also uses a short watchdog timeout to reset
> this SoC.
> 
> Implement the restart operation by stopping the watchdog, loading the
> minimum count of two ticks and starting it again. A count below two
> does not trigger a reset, as also documented by the U-Boot BCM6345
> watchdog driver.
> 
> Disable local interrupts across the register sequence and
> reset wait  so preemptible uniprocessor MIPS kernels cannot run
> a competing watchdog operation.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Justin Chen <justin.chen@bradcom.com>
