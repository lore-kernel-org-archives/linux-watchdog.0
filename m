Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B7B49738A
	for <linux-watchdog@vger.kernel.org>; Wed,  7 Oct 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370503; cv=none; b=suq7aFKUqYUDGSaf/wKLGMHqxpxxgma1PxIWSAHQdgwk0WFgG4g9s49HFBIsimDuA/RIvzljKXtxMgDGa2ODpasOX2Cyy0wkC5TdjOWTHDA88kYcofJ04Vou1SorNpTXbQhHvz9vQnCmtTNVstXDfbzU8baBTO8mkz1OCOT1hBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370503; c=relaxed/simple;
	bh=9dq62m3H/F3g3zRJR8cbGc7NrlaKI8XcS20SBv3jLD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDImAXJINnhbL2lZQ9N3C1e1BsmeK/OtYmYSIrThBDTGYNGRTIJ6AGeA1G6Kxc5taNL30JrvL6wI+H/jStSxfEwr1+WdFhG3rWYoT+jAuDSvToHScJ4N6aoAb+X/37WUjKoofHps6rKOdtfQlyYY8sCgsQq+JtVsVG3TTaIlzhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nGGxO3el; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sx1CFM3B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nGGxO3el";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sx1CFM3B"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6977jWVA3810926
	for <linux-watchdog@vger.kernel.org>; Wed, 7 Oct 2026 10:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ayl6Ws4PcGeASqdKrp2tsufSNOTZIqHFZ6GMGypWAe8=; b=nGGxO3el6RrkEccf
	PiG6Xvp104NatUfNIqHeLOpjIWmBPWPHApMA4EQmtxpV9+H+CgZ9p4Rs63rZ+MhP
	wswUmSNc+ZgzdF/ywDvMSYy3jIKVEhJF1fH1j6V6OiQLFyyUJquFuukMBuXOG9YH
	8hoFBmCvAeBK76KPsA5YCWpmCuqK/6wViAca6dGo3e/3SEklWfmt+IMfKRE148q5
	3VMyQNTY00gC1o9SOGvORoB4BhA7rOyhcfvU0vsbiBuyzAvpRmoBqxbWRNbilbtL
	FS038OpufH46yCtFj3sZ3Um0m3aMcRgdm6CEnMz4LhR6sSd3vi4wcYzdMiU6MNfD
	1eGCmQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5gvrrv1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 07 Oct 2026 10:54:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e82060977so635093785a.1
        for <linux-watchdog@vger.kernel.org>; Wed, 07 Oct 2026 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791370474; x=1791975274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ayl6Ws4PcGeASqdKrp2tsufSNOTZIqHFZ6GMGypWAe8=;
        b=Sx1CFM3BdM2hrbVYHrGuogj1BC7MAdn/uWXCwZwnMXVMoQ98lM96Cd92TC2urpnpUW
         FzsLnLqaBuid7NknqLnjhITYFqpe5tmYyix8Z/6qZc9pqmlfvpO/AIx5uBkeOzlzpoG9
         vztdncu/jzHMA3Aa8X5tvyJQts3JyLKFA+2EHY48Qjz6XX8vPvXPX8pafvuBVsJczh2F
         gnQ7QJ9jyS+IfAP1qGSFBZrrx15jguTk2M8MfD8GpsyIRi3mWzLwUbKtrtFNiQ1w7cM1
         ZAhfqj003wNIMjOuOhtLU5ivV4TJrlGtgrEzhOSh1ekGgrwbUI9fA6VxLknHFJ0zx68g
         0djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791370474; x=1791975274;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ayl6Ws4PcGeASqdKrp2tsufSNOTZIqHFZ6GMGypWAe8=;
        b=q26DrQTAY5ooc57h9m01XAEdrxt3+8bt+dfta31tOeemn9dAgSVoOzrdRC9H0AVMbo
         yhDTEy1VBCibQARx693BYULfd5Btkcl0gbO1no7FlZIJxWpJsImE6ElGhEILMbyKGCyz
         U7lvX3iXSqwCdp/3mfGtRJWnDDTgjmFxaHFggLBeE1SgT+OmYWGRTP/Yele28oUYgByh
         9uPwfghIWD3mUvYFHeLiuFbTYgp3XdCPH5Q/PnzCf38JqhRl7Nk8ghmbHJamj1XTK007
         yQ5ne2itulRHKIKsTsgw/OrU6aywxrcDwaWyvPHtYCp3dHbk/OHRWP4ihhRYlqPxZBPe
         XrfA==
X-Forwarded-Encrypted: i=1; AKwUvBxXedSu/mUirW7tzSg0bBwdoE/Ib/B8x3+dIbOqCWRbPMZHhsNrwrEMxLJR/dPUiNDqXDmsdc4cM6YIAiJXBQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mk5MwdxH1Q4hwrVhOHH8u+gEUAK62svHro8QXnkl2ceVxbzC/K
	ZTpT7DZ27gnGy547ethxyGD8JYVrd0RYIRhQrcdNAyZyDClU6NNnXomd51RadlxlLJ7pnkPXwQb
	K9BhEOnM0YfrMX1EH6EeRKomfS1J9Kgu+RBWNEWy4boA5wjvHZE9LR4P+P5AiwClHsJnUDQ==
X-Gm-Gg: AYBFou01rklFM6cOesEZ4UF//hn/5UqOjRL1PcOO92/JGuC8XlL0r5slXb58oP3Dips
	50GcaFF2ghp65W0NwtsfPYMErVMJWcHMHIxnQLscvbU1W/sbCMZqnUbDdjUSx2eIZg1IkKlJ+5O
	49SeCFTX7KsD5zhGoZGCz3Cgpb/+BzkQo5zc4aqMc7vidv0ngBYLNMtb7kfW7S1j9Y7eZB3vvAW
	Og4RHiBLEKk3AUz85x2UIqRJrlkmq7T3oHNXdypTvIjWKEI5DQ5dH2EYcYucqmz/KruyRx7SNE3
	Y+H2ey+nZQWbDJamj+K+5Rhv4th3I6zvUHFnz0trAIsmzdMvmuKYVL3QPWPwhe0mSi21oT36e+C
	ZuB+u1QnCtxqfYucE
X-Received: by 2002:a05:620a:280c:b0:93a:1196:ce5 with SMTP id af79cd13be357-93e860fc57cmr1064338185a.33.1791370474171;
        Wed, 07 Oct 2026 03:54:34 -0700 (PDT)
X-Received: by 2002:a05:620a:280c:b0:93a:1196:ce5 with SMTP id af79cd13be357-93e860fc57cmr1064333185a.33.1791370473462;
        Wed, 07 Oct 2026 03:54:33 -0700 (PDT)
Received: from [10.40.4.23] ([37.168.19.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1272esm4743724f8f.27.2026.10.07.03.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 03:54:32 -0700 (PDT)
Message-ID: <07562f41-c269-48b7-9ca2-be324282a456@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:54:24 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 2/3] power: reset: pscrr: add watchdog pretimeout
 reason tracking
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Wim Van Sebroeck
 <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?UTF-8?Q?S=C3=B8ren_Andersen?=
 <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260805-pscrr-reboot-reason-v4-0-54ef517084cc@oss.qualcomm.com>
 <20260805-pscrr-reboot-reason-v4-2-54ef517084cc@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260805-pscrr-reboot-reason-v4-2-54ef517084cc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=W66txhWk c=1 sm=1 tr=0 ts=6ac624ea cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=YKLnzF1Vlz+PFNxJOoRadg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=mRuXk5Kx-r9qf5YVW5kA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: No3w7wvL5JP-HV1xKn1FgajUVgSf1uVP
X-Proofpoint-GUID: No3w7wvL5JP-HV1xKn1FgajUVgSf1uVP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MyBTYWx0ZWRfXzcfVyB0Jsl0h
 8Y6hNR22rMH/4ZYSQjCnmoe/pg+5Z2URXFr62/Hv/4RQUcJwRP3PQ/zdTz7iTTTRd8FrMFiskeT
 UwQXSufqc6iYINrTGESOSmqray5LbfXihlB546HSqlktu+EEHnoEuJT+yrOObIYywGwGE2DYLeo
 dV93gEtFQfKAqgDu5QqWpNP/6w/pi0mBE7RA8bGnqNsqld5nqRKMmJrXgtM2fD6MzMOdWoVXkiW
 XcP6mUKJol9mPWMloIP8MuOMyYuIa2NBfVXoIqfKJHOUjMEOvSRDXVGGbwRK+sH9acWjHLTwvLD
 FjrjxM11+FEF+zbu/8tl6U/6995O6V8R+rnHXmgtQrbjI4t3yKrbYXEhDBs9zuld5kmQJy74/S6
 iDui5OrRYU7+HSftdz3jw46Qg2Ex71s50Uh0YJNhtCjCwn+2dXjePcZuIRvQ0jBCWJObZm4drr1
 3Zdwx9QCKwA3iNFAFhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MyBTYWx0ZWRfXwn2acPFeB6nk
 G8TBB1Ma6Vv9kV4PWYJlUkrPqNE7gNVLTdQ+4htbQo6cVFfYsvxun+9qlJog5viNFPYO+t6oAzl
 FfzaTnt61Hf4sbkR4dC9EF7XPD6/RRU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070043

On 8/5/26 10:54, Faruque Ansari wrote:
> Watchdog pretimeout resets are not recorded with a dedicated reason,
> causing subsequent boots to report PSCR_UNKNOWN and making it difficult
> to distinguish them from other unexpected resets.
> 
> Add PSCR_WATCHDOG_PRETIMEOUT as a dedicated reason code and prevent the
> panic notifier from overwriting a watchdog pretimeout reason with
> PSCR_KERNEL_PANIC when the pretimeout governor triggers a panic.
> 
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> ---
>   drivers/power/reset/pscrr/pscrr.c     | 11 +++++++----
>   include/linux/power/power_on_reason.h |  1 +
>   include/linux/reboot.h                |  4 ++++
>   kernel/reboot.c                       |  1 +
>   4 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/reset/pscrr/pscrr.c b/drivers/power/reset/pscrr/pscrr.c
> index 8c45b84059a9..b7e6239e207e 100644
> --- a/drivers/power/reset/pscrr/pscrr.c
> +++ b/drivers/power/reset/pscrr/pscrr.c
> @@ -529,12 +529,15 @@ static struct notifier_block pscrr_reboot_nb = {
>   static int pscrr_panic_notifier(struct notifier_block *nb,
>   				unsigned long action, void *unused)
>   {
> -	struct pscrr_provider_dir *dir;
>   
> -	set_psc_reason(PSCR_KERNEL_PANIC);
> +	/*
> +	 * Do not overwrite a watchdog pretimeout reason already set by the
> +	 * pretimeout path before it triggered this panic.
> +	 */
> +	if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
> +		set_psc_reason(PSCR_KERNEL_PANIC);

It does not sounds correct.

May be you should move the set_psc_reason() to different places for panic.

I did not explore the panic() function but I would suggest to have 
something like:

panic(..., ) --> defaults to PSCR_KERNEL_PANIC

panic_with_pscrr(..., reason)

Then pscrr_panic_notifier() only does the record

> -	list_for_each_entry(dir, &pscrr_dirs, node)
> -		pscrr_do_record(dir, get_psc_reason());
> +	pscrr_record_current();
>   
>   	return NOTIFY_DONE;
>   }
> diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
> index 8c99bdd75021..8e3889fa43ef 100644
> --- a/include/linux/power/power_on_reason.h
> +++ b/include/linux/power/power_on_reason.h
> @@ -21,5 +21,6 @@
>   #define POWER_ON_REASON_EC_PANIC "EC panic"
>   #define POWER_ON_REASON_EXTERNAL "external reset"
>   #define POWER_ON_REASON_KERNEL_PANIC "kernel panic"
> +#define POWER_ON_REASON_WATCHDOG_PRETIMEOUT "watchdog pretimeout"
>   
>   #endif /* POWER_ON_REASON_H */
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index a117dd5eaecd..6d5ecc6cdc00 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -243,6 +243,9 @@ extern void orderly_reboot(void);
>    *
>    * @PSCR_KERNEL_PANIC: Reset that followed a kernel panic.
>    *
> + * @PSCR_WATCHDOG_PRETIMEOUT: Recorded when a watchdog pretimeout fires, before
> + *  the pretimeout governor brings the system down.
> + *
>    * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
>    *	value is useful for range checking and potential future extensions
>    *	while maintaining compatibility.
> @@ -267,6 +270,7 @@ enum psc_reason {
>   	PSCR_CPU_CLK_FAIL,
>   	PSCR_XTAL_FAIL,
>   	PSCR_KERNEL_PANIC,
> +	PSCR_WATCHDOG_PRETIMEOUT,
>   
>   	/* Number of reasons */
>   	PSCR_REASON_COUNT,
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 979ecf3b093c..fad4ef9681a6 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -1110,6 +1110,7 @@ static const struct psc_reason_desc psc_reason_descs[] = {
>   	[PSCR_CPU_CLK_FAIL]	 = { "cpu-clock-failure", POWER_ON_REASON_CPU_CLK_FAIL },
>   	[PSCR_XTAL_FAIL]	 = { "crystal-failure",	  POWER_ON_REASON_XTAL_FAIL },
>   	[PSCR_KERNEL_PANIC]	 = { "kernel-panic",	  POWER_ON_REASON_KERNEL_PANIC },
> +	[PSCR_WATCHDOG_PRETIMEOUT] = { "watchdog-pretimeout", POWER_ON_REASON_WATCHDOG_PRETIMEOUT },
>   };
>   
>   /**
> 

