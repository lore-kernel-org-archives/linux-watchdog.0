Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459921;
	b=oYpt+rHHl8sl3U97sal7A9W2bmjP/tFNvGrNOJfRyzF2N957HPpC95Iu9vNKSJVz1C1Y
	 34v95LgGFskt7mM4qstkGezJql89UEtkQvAn0RTkl8YqvlvWOkzjCCIVExrqaWa4O6mo0
	 cMddMzyzdMDulYOgCVZF29LBbdJ1+OOYp+2uNcn+E7WYSchzXR5tlrfxcRTCVo7UqzzIo
	 O5CDEdLZOObGTq/8nT+0y5dyREboTxoMimm4a4cUqXzoXbzgy5+aWSxDccFnUEOs7fU2p
	 nSU62gQOuCE0u9uLtrvS+9neKADfCLi/CwyyiE1yadrpnH7BlI3y6dm1PWfXWStl0fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WI5DKo8oCSKJK2cG+AvlYTjWkEWIpjCG/lSE1vuXT90=;
	b=0L23J0enCqDYHUrlXZbZ0cEKa6sKgzl4s6GVqYWR67KqKYj0d1k0fHv1R5Fh7t2pcKEE
	 6NL0Jb2CY6RamVpPyqGl5g9peWXKuMWaZY4PSOFAnyF3xixSI1S4Ug+J/nqQPVYrgpE85
	 Xm9uDYOF6NGoUGnXxFCFMYH0ej+sblPQdJQI2QVnex/JsCvG0K0bwCr9g9f/MEd6SwMMt
	 ZbUyDg85xhofxn0wu+rYeZSuI+PYB1iEcft+7e8DqriDrv3HoC6AvuEMK78pMksuBYNJT
	 KuoIHHZGK/+QWbxlGUeODacx5M3OnHMGzgYOauR+cgjCnjSwO46sdOhqspcZsQSlJng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=flvAGSLb;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDBD606A319
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FDBD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=flvAGSLb
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35ef6b49813so5113436eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792459919; x=1793064719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WI5DKo8oCSKJK2cG+AvlYTjWkEWIpjCG/lSE1vuXT90=;
        b=flvAGSLbs1TE70oN1MCcj83ZHVKj1L7AL+qNWtEKVsZuQDbZACezKaQ7/3/6S9Nk62
         od61bRDiyW3MSu0DHi4hqPuSMFifGPC7zMPM+bCprUZyyqF1dofXABYKcKxyoyO18osc
         D/8rYVs3bxYSnaTjhqw41S10d5qBwRi1vfJHexr7BNwNtcAGTkuGx3mpKoBFNkWODY4P
         g72TO4UM0fwi8yZIzgnf3o4yFggv9y/AQ4qxP+zkgjRCIDlc4gvoww9w+6UEkaSlryIx
         O6iDL4zQQ2Yip6YF84gACUr3SQu+zFp/JccpL7gZy2xpRj1CjJbCc+M1/1I3sepwn3Nk
         wIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792459919; x=1793064719;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WI5DKo8oCSKJK2cG+AvlYTjWkEWIpjCG/lSE1vuXT90=;
        b=0gciHdGRASwjV7Lh7t2IhPwDOxw67sWJsN21+vemo8eB7ZByFyxeprioRWfJVKbXHn
         9VI1vnhibdD1++A8iM7wZ3Uu99m4Q3VhsjR/Fgeln2UfBUqRwvTD0ityy6atTpybRhil
         wFgOK8m+d3rPsII5xeMylbTWcjvOHuZv81m0yVOuJUpLazwqN3+5oE9/dSCAHmzTXHgL
         xPU5JPgwATm48sv3fm1K2+pXST5yU23R9FzBZeCCvQnNHzczCr78S/6PbDp8yZEwe8TZ
         NISConzcejrPU/5UVL+xMO0HvoF6eNLvoWRi103nszc8Lx9EuHHWcGgO7+AtE7jL7lTi
         gg0g==
X-Forwarded-Encrypted: i=1; AKwUvBwz4wL2Q2F5V7DRonePb+QzZTN2b5Ka+nW7bffSNlhsLKccsGtqUJuwVecDmxJoNuzLqMMh2bHgs2czkSachQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKAgjk8TQ55fr6B3n7MvlngfM6WrXCq1snIiFwyn+jSF8mg3tcx
	gJkOGLTewG+fTi3Kifze1YhtAwY0Yah8CSfRZzEDBmKK41jp2KIpoN/Q
X-Gm-Gg: AYBFou0/+HeDKBw0xHNZtgWQ5rST59mKHKPQZRbt8a9Nu+eFsqbyA/dDFNOJx48e9LK
	a6gbroSO0pyZbtmUDQlh8+W7S17/C+OfMcB/IQdCHmfQNTrDMyoc41nLDaDYBNEoNc1AzaoSkj/
	OGUF1FXDUdQg8sZjsAx16f7VUv1vZioPTTCMOcnuqiE6pLAmwAQFjnoUZNGOWRsE3xgHTmrMNVv
	hId0VXmJObDLV1bbOBJe0eF8BnF/mZDSyWj+GVOgumEa4IGADKFW2AxzSm1rqMbGGkJJykrEuCV
	epugb6NOpcl+PSR3OWZwgzYrV4x4VsGQxAj3ouOVhWJzX4AX05kVvIO+Tk6dF3MITY7gJTCfcEh
	OgbdrPdSBomJfvoQaOGFTgvIss4celOyJdr8H9xJrDvsWUecQPaWRJBTS4harOTwuFSqK9e33cW
	yDoNaBYC6zhrzQK88MveSRSq8szXtSj0ky8iwB8VLNFk3PtYplXH3Kl+xOYJN5Bqt6Z84HHcwsL
	DUoRKtXt6+HafYkOoKzMwk=
X-Received: by 2002:a05:693c:884f:b0:35f:2858:aa4b with SMTP id 5a478bee46e88-361a2c36e5fmr12150170eec.30.1792459919142;
        Mon, 19 Oct 2026 18:31:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081fa5a6esm37005251eec.16.2026.10.19.18.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:31:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:31:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linusw@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: bcm7038: Add a restart callback
Message-ID: <9eb2cc20-d19c-46d7-8a18-6c894d6cf464@roeck-us.net>
References: <20261015-genexis-xg6846-watchdog-reset-v1-1-9577d65223d5@kernel.org>
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
In-Reply-To: <20261015-genexis-xg6846-watchdog-reset-v1-1-9577d65223d5@kernel.org>

On Thu, Oct 15, 2026 at 12:39:29AM +0200, Linus Walleij wrote:
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
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Justin Chen <justin.chen@bradcom.com>

Applied.

Thanks,
Guenter
