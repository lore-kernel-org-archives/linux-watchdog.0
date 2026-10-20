Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459781;
	b=bbm8HUJlpM9tAOcfNa3DoQLq7jf+KYQ/GRXq1BOwg6hhV7OcV3lomAChB+NzWEZve72l
	 Ybbsrj/sL6gL1zq0wpm835SDucJRHPjfReS96M/qMyQwkkRSH+NmXbVezoHVVQb+UK0CZ
	 rqAcPbATudvniIa3cSljejXyWbRdnrsLGbDPYgogcU1xB9WUyjKeCdSiQRvq7y6FmRxg1
	 zDCUdMGM37YJWXh7GSkowdQRO+XsHUWIihskDK6PErRDQsf0URfwwdMZBvF8hSx01nEPI
	 1Pw95US+WVW1S0hkYgGhJ8yYrr8y0QgvJu6LxUFKIvlCNIVbKrOIdxHR0waZpsmdFYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=QT3eFXHVHoqDLuSaSFM8eK63zSLUEeeoFpkJDMWYrL0=;
	b=xigqqol699ldT0CVuPB5+Jq3EETvLXBbhSNxc5RrsZO7M7H0s16TCXQvnfAdPkJuzK62
	 jPgO8O93O4CmkXC1ihfWwW7gftIoFliOITZYZpxtbYVTCYJWmRcD3+Gyivdo/cv5BBIyi
	 G36tab4bn1Bw+1Ff0T7Ff31o/SY+bHHmOo9GPkyz2ZKiFoHfjW94Pt4sFzjsVWXEtrmht
	 KF14ftbrOJArTHKgK11QnvdC4IJh3oAsa0iALOrtoNdmxUN08WCahu0aTrMxIun8H885F
	 TurLLB+yfB9bjUsW6qAOD5LU3Y04pS6eGAV03FqRg/6tw6KbpYvw2tz70SpbzFhWYKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XxUN2kZ6;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F7A606A31D
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F7A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XxUN2kZ6
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35c76e9614aso5151577eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792459780; x=1793064580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QT3eFXHVHoqDLuSaSFM8eK63zSLUEeeoFpkJDMWYrL0=;
        b=XxUN2kZ6oEaNF06NIkbaryynlksV1cMlxhrkyWtOISac7KzbtvUgeFnp+pcITmQZo6
         7AFTE+xDCMWFB+Ka8hPWmtY2+ouBmJJsz7SFOycY9AVFqqjPFDTIu4Wqbu596LB/c8y2
         hw7uTy+fEPpI5avdn9oR0gwb+8dMYujIZ2owbXkrQh4NeT9ExNYRiCndy27rStV9CZ4n
         AJX8EJqDvZ6gUrRhlZce8XO2+M8PdnA+eHtnJu6gzYkAyBMSxE/HaqxBu8UmYooBsWMX
         Pwt+VbKoawGN1yuYtTfxtD4d3xHe2zuw3X+FRB4cRQvrZ6Iur5RSVRHzbUNmSWPRiGMP
         K4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792459780; x=1793064580;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QT3eFXHVHoqDLuSaSFM8eK63zSLUEeeoFpkJDMWYrL0=;
        b=RK76gNrJjFVJRv+HaDmJA2WwxAtoE6UcCSTdYCC9ahlW8KTZC0PedqYx9wwAXNIvh9
         f8vRAqGFPA8JZTwBihz4heTV0e0EEo/4543Rwswp+PVFx7Wz0p1SIRhoy8A38JRjkfHk
         xvOY18LLP8nwI2QEUpR5pQXvouMmCW8ryFxSJZA0j5WB++SmltS65ETGH7BkR5k/7SMy
         iaODb091fjD3AmMZcxnWa3gIIHn8GdBVg9uDgKLxyXrnOwFjN1JN3swMT0lDcLgpI0nI
         pn3lMwpzJ+dD1XtQ0TRT27UcgnEP0fYPctemfvJ+bOGEX7QhOlQSl6HhrHojRFF2OEiP
         vIkw==
X-Forwarded-Encrypted: i=1; AKwUvBwDT63263QIoeVqfwigzCQqA980BRBw4If5luWhueiHGlZft0JagFwrdR40DUw0SFcIpFGu2ufymsaOOP4lqQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLcqxmYzW/Q+NiDUkzRxstkvzv5P4T3E0X57XQgL+vVFLFfBAEo
	oj1C+pMMwTVSk2LO4p8ztWXkhxV7LguwSKJeDETSwHoZPhXuUzmG8mDc
X-Gm-Gg: AYBFou0bcLrTf8Q9jIrsIwEZSgToQCkvKdN0YxrT2mfElM5Yvmpx55hjz7DslXLJ1Iu
	FPm/Snq7EKUABuFhTys9q7TCUOkO7OW7TU3YWhIKBgWud1d2YMLs4ONau2IcAqjBk3+fgMnu2Xz
	sx+ZpCLeLhJUD0LrzD1jf8YVBQjvyls2fkQK5z2/NgD5JcjKsdWTpwKoF2FBjINgzyMDAs1rXCS
	mZ1rEVSZNaN4gjzuc5hKM2IXDfF6ysVq3KVj4GjibRQkp7yGbWjJnX/18pHBr5KeaVkbw4CNKDE
	WUm341uEuJ4+NydtPqbXw4dQ9YfDKiPoGd/pMxddnVrgzvKAiDnIzumSZsH10wwkp/fXUm2weQ5
	QxksYumDSB1DtmsIc3DjzeIgsdwiGXhkDxpgEo8BDGWosC9TH03UoI8xkNgPEGyfFQLh6wjcrHG
	4bH7Hrycz/12kgmdUS/qTMCc+fed9rGTT59bQ3B24Ngi5j3e1NOGpfi3QAuQlWaUAaXzJb5usc7
	jFjc5TIW6CY
X-Received: by 2002:a05:701b:42c3:10b0:168:6ad8:e89d with SMTP id a92af1059eb24-18511eb6876mr14641867c88.11.1792459779536;
        Mon, 19 Oct 2026 18:29:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f58c2sm49277908c88.11.2026.10.19.18.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:29:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:29:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: qcom-wdt: Document SM8750
 watchdog
Message-ID: <10d6863a-67ac-42c4-86b6-aa3b0871b502@roeck-us.net>
References: <20260930-sm8750-watchdog-v2-0-b16fcda275d2@oss.qualcomm.com>
 <20260930-sm8750-watchdog-v2-1-b16fcda275d2@oss.qualcomm.com>
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
In-Reply-To: <20260930-sm8750-watchdog-v2-1-b16fcda275d2@oss.qualcomm.com>

On Wed, Sep 30, 2026 at 06:32:05PM +0530, Komal Bajaj wrote:
> Add the SM8750 compatible string to Qualcomm watchdog binding.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>

Applied.

Thanks,
Guenter
