Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5793F41A50B
	for <linux-watchdog@vger.kernel.org>; Mon, 12 Oct 2026 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803184; cv=none; b=UdGZjsQR8McsKtarCUz8pnD2xb3k5/7UHHfZYCXZXomo0oDyIKK2VjBAon0CkXEP6fWvCfGyLYArYq3jaqKqV+moDVtZmGdoDdgCue0W1dJPyKcsrLQ/oUf0jlZDZoCDntMMJmwZwuZxVtefjqZn3Kc871vL3soZZWc3++/NrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803184; c=relaxed/simple;
	bh=A72ciOolcvKp1dYuivzjI6CjBbAygAt15osgfOUzlcs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Yrq4FCye0CGd1GB89H5WM+iZoUN404mSJ27c6MGtXulQythCo0FpsA7u9OXAett7Q7d6fMoXza+qAVs8IQ3N6VnZDCAUI3JAt2biiKLVu57dGZ/vruGNU6o1GUdtE7/XgsUvgb6dBZ5InzgK0GklLGIND18MMxKfLKs8v1EsuS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cHBzu5+w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BEgfZKne; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cHBzu5+w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BEgfZKne"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CA03XZ3098922
	for <linux-watchdog@vger.kernel.org>; Mon, 12 Oct 2026 11:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UPAzFbkqHrqh1U+dVDo3vXYHCvqIopcxz3ms4FKDc10=; b=cHBzu5+we6WupVaS
	tnvfDd9JbxZgNF5hGfQTVs5xFNqTepMf2Qw7L3+s41Vn9hRxK5ybm0FKXmM9FXOw
	MRwHoAa3LqyzpxYiQQThNlJizRKqor3BZEwnTKvbpxqlIINX0o3GMy1g1mfnc4st
	zXQK0YT6AaLKgNwL8tbi2tq53279pxm5yd5Ar3GEHvdv/DqBf6WhrmxAPTXfwsDr
	TyoUlebmiXb7a/JuLR4m6sa0puT5QNyZV24l4hRfqf+ZPoK+TnS5lk4at0642KNj
	jWNkYbZLPqCfx4Z3/SBt4xEiousrB4wyPzJBPNTY18tYtQm+4B6J3Qp3O/XpyeKD
	btVMxg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wdr8c3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 12 Oct 2026 11:06:19 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-88322409239so19556207b3.1
        for <linux-watchdog@vger.kernel.org>; Mon, 12 Oct 2026 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791803178; x=1792407978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UPAzFbkqHrqh1U+dVDo3vXYHCvqIopcxz3ms4FKDc10=;
        b=BEgfZKneC0jSgXSFryRnRClhjlY7q2xlHwTcDYPVcdAxMu99fKfFV6yfldd6GqgGwM
         p7Og6UtJB0740UBSHssngdFL6f6ziTManbCPPVCF1W2nLuARICY8tMh2ib6mcgqd5kCw
         vwd8+h6ey34l7+aLbx/qLskxbL3q1VK5h5P3i1vS4yVjGjXVfHVnKxWG9j85uAiNF3PL
         Nj+Tg++WHDVElSVEGTChmQCdqHGYjY9xZ0UVM1t6r4VV37ciFtgyXgcJIo5UaGoKIQk1
         xAVKBfGlY9sNeIXiQero6K9lUGTOYUueBfI90WFuvHAq80poOiXjx76IOg+8/cNC5Ntm
         b5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791803178; x=1792407978;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UPAzFbkqHrqh1U+dVDo3vXYHCvqIopcxz3ms4FKDc10=;
        b=tmz3YLfBYNB3kQtgv8DA62dnlw11vgap0LQoRL6a23FSPdgvTQkF/XhD7r1GIX8YOe
         F7bnuE7cVgf/enZ5y4VqOYDBHe7eDjMB+A8YNIDSrFkpcwTHnoTgjivF8OTyOKEvl4A6
         BlmKvg7BQ0qX2gEhskuqq/u/2YwOk8s0+Dn22hKZBl5sHjzCUsY9Dzlsp4KOp8lslhPz
         nRkmhujsewZjtOq0hu+RW+QMgaqlq2CS6yK7kwE9c+8zSSTo0WKDTEBG3eeUEa1cMsSo
         Nq6CwuIrUb3Y8KGups60c7/SpsdIQ9MOsPcR6opVpbNdTlSMWqqZxlUDOIgk/+7lhIwc
         1fuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTHyPFpSyqy5k0LUGe67ysRjg0BDIk9GgXuJ81qNqgIQiTNkS0lnbNo6Nl642GNCxWNzAkuILGqcKfB//Eng==@vger.kernel.org
X-Gm-Message-State: AFq9FYLemY2TrW4cptinJFEUsn1fM6qehFdUWFNYItmQMUcvZLTFD+aA
	vPEP8roSoMRTvTY2D0G+yIQ8gMTXKuuzzcCw30kouY6X6hTOcw6j7LC1aZRcLoeSOMtLGxXykXz
	d+TBZG+AwsQlhdYPNLJB/ttwgnlp8MrpMb3dMkeW7kH8LYa8M202bZigj5jRuL3Q3emXy
X-Gm-Gg: AYBFou1oUB3CyVO4NQitKw1vQJmxW42cV5mYsiocZ31Wkvek5yPd2hcMV5yaq4TtD8k
	0j9UaaBU7tQwXESgtFhn6NeNMilsv4y4tBJHy5FkyLa2dT1VPpvah4fxFWSvrMJSQ0Zpa3al8a3
	1UShhzl6U/YXopwp5wTEo5pm0sDQaCN61rZahPJx0oRzopHadwSSdAs83sxCVUJRqJghgAB84bs
	+ztBSrJH+jVa2YuI9S83UfKUt/aUjXO31yDiaWZHQzf4ztI3e4lDHnlpYwMprvPyncpJR81MYxe
	hLjuLFfLvpwTcqBQJ2/2y4fECKChEjm31K2XMp4G0B9RTdcl7EtRN2p9KaCvWYDVYQT7WRPGYWz
	1UOLCLfYa4Ozd4hrOZcpbzpMn2DCkiA==
X-Received: by 2002:a05:690c:e3ca:b0:8b0:a587:9447 with SMTP id 00721157ae682-8b0a587af48mr7610297b3.38.1791803178306;
        Mon, 12 Oct 2026 04:06:18 -0700 (PDT)
X-Received: by 2002:a05:690c:e3ca:b0:8b0:a587:9447 with SMTP id 00721157ae682-8b0a587af48mr7610007b3.38.1791803177727;
        Mon, 12 Oct 2026 04:06:17 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f22edfasm31501227b3.34.2026.10.12.04.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 04:06:17 -0700 (PDT)
Message-ID: <8774f401-7efa-4577-8d03-6fe652e856e3@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 16:36:06 +0530
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/3] power: reset: pscrr: add watchdog pretimeout
 reason tracking
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
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
 <07562f41-c269-48b7-9ca2-be324282a456@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <07562f41-c269-48b7-9ca2-be324282a456@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfXzU3fztYhSRi+
 Hi4HM/UU2tulR3Vcps9vRcL+a5vLeZqSyqir+g8q1mlViIphPX4n8jNKEce1T+uifWA6JdjiNkt
 4HXse2kh1pyuvlPGdTxwwXS0yZ9fhGDdB9u2ZX2HTVp5kQbB0e0gS0gogSXTsACtAVBQBnU4V6u
 4oRU5QAYTcAPoRtTO2AgOlhVWCtOAwB1pxknRx54z+6h97qLhYJx+Ll8uqHUpKIqEu0UeawU+fh
 fZTR/m7GTj3drRoP6ZVDzW5tkikko/WG/q8UuP6bEyTCz+vke/4Y2LiIhg284RkPSN7EVIIBJ00
 vloLCZiEsY6V08k5Eyq03t+lLTr7KVV/zbGVMZkqcoGdqXWmZx8nue7Qms55JWC+zqC4A6+mOOY
 W5IppklkuRV6yLuSBfjTfN4Ui9ovMYW2Nci1P3NUfRd9JWTvfuzz/ebiStq25ShTFVL8kxMeeCd
 YD2LuSuvsoENgpFbd1w==
X-Authority-Analysis: v=2.4 cv=SvAFe/O0 c=1 sm=1 tr=0 ts=6accbf2b cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=fO_Mk5cv7Jo2rvO2W84A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfX1NbohQe9aHI2
 PhCurQxOqqm9S+L2iZaMeRJVBuSpTQtw/lYatq3O5QLDokfZZEFtGG9txjbEMtyxp715DYlka4L
 6pQOLYQ9WHEHRd/2xKPXOCXvj5rWujo=
X-Proofpoint-ORIG-GUID: 7F9aLsb08ed_ZuDTwgqNrTVlPKfMxJoQ
X-Proofpoint-GUID: 7F9aLsb08ed_ZuDTwgqNrTVlPKfMxJoQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120044


Hi Daniel Lezcano,

On 07-Oct-26 4:24 PM, Daniel Lezcano wrote:
> On 8/5/26 10:54, Faruque Ansari wrote:
>> Watchdog pretimeout resets are not recorded with a dedicated 
>> reason,
>> causing subsequent boots to report PSCR_UNKNOWN and making it 
>> difficult
>> to distinguish them from other unexpected resets.
>>
>> Add PSCR_WATCHDOG_PRETIMEOUT as a dedicated reason code and 
>> prevent the
>> panic notifier from overwriting a watchdog pretimeout reason with
>> PSCR_KERNEL_PANIC when the pretimeout governor triggers a panic.
>>
>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>> ---
>>   drivers/power/reset/pscrr/pscrr.c     | 11 +++++++----
>>   include/linux/power/power_on_reason.h |  1 +
>>   include/linux/reboot.h                |  4 ++++
>>   kernel/reboot.c                       |  1 +
>>   4 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/power/reset/pscrr/pscrr.c b/drivers/power/ 
>> reset/pscrr/pscrr.c
>> index 8c45b84059a9..b7e6239e207e 100644
>> --- a/drivers/power/reset/pscrr/pscrr.c
>> +++ b/drivers/power/reset/pscrr/pscrr.c
>> @@ -529,12 +529,15 @@ static struct notifier_block 
>> pscrr_reboot_nb = {
>>   static int pscrr_panic_notifier(struct notifier_block *nb,
>>                   unsigned long action, void *unused)
>>   {
>> -    struct pscrr_provider_dir *dir;
>> -    set_psc_reason(PSCR_KERNEL_PANIC);
>> +    /*
>> +     * Do not overwrite a watchdog pretimeout reason already 
>> set by the
>> +     * pretimeout path before it triggered this panic.
>> +     */
>> +    if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
>> +        set_psc_reason(PSCR_KERNEL_PANIC);
> 
> It does not sounds correct.
> 
> May be you should move the set_psc_reason() to different places 
> for panic.
> 
> I did not explore the panic() function but I would suggest to 
> have something like:
> 
> panic(..., ) --> defaults to PSCR_KERNEL_PANIC
> 
> panic_with_pscrr(..., reason)
> 
> Then pscrr_panic_notifier() only does the record

Thanks for your review.

I agree that handling the kernel panic reason in this notifier 
may not be the ideal approach today. However, my intention is to 
add userspace crash recording support in the future as well. 
Since this notifier already serves as the common point for 
recording restart reasons, it seems like the most appropriate 
place to handle userspace-triggered reboot reasons when that 
support is added.

For consistency, I added the handling for kernel panic and 
watchdog reset reasons here as well. While they are not strictly 
required for the current use case, this notifier is the most 
suitable place to record reboot reasons. Keeping all reboot 
reason handling in one place will also make it easier to add 
userspace reboot/crash recording support in the future, without 
introducing a separate mechanism later.


Thanks,
Faruque Ansari

> 
>> -    list_for_each_entry(dir, &pscrr_dirs, node)
>> -        pscrr_do_record(dir, get_psc_reason());
>> +    pscrr_record_current();
>>       return NOTIFY_DONE;
>>   }
>> diff --git a/include/linux/power/power_on_reason.h b/include/ 
>> linux/power/power_on_reason.h
>> index 8c99bdd75021..8e3889fa43ef 100644
>> --- a/include/linux/power/power_on_reason.h
>> +++ b/include/linux/power/power_on_reason.h
>> @@ -21,5 +21,6 @@
>>   #define POWER_ON_REASON_EC_PANIC "EC panic"
>>   #define POWER_ON_REASON_EXTERNAL "external reset"
>>   #define POWER_ON_REASON_KERNEL_PANIC "kernel panic"
>> +#define POWER_ON_REASON_WATCHDOG_PRETIMEOUT "watchdog pretimeout"
>>   #endif /* POWER_ON_REASON_H */
>> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
>> index a117dd5eaecd..6d5ecc6cdc00 100644
>> --- a/include/linux/reboot.h
>> +++ b/include/linux/reboot.h
>> @@ -243,6 +243,9 @@ extern void orderly_reboot(void);
>>    *
>>    * @PSCR_KERNEL_PANIC: Reset that followed a kernel panic.
>>    *
>> + * @PSCR_WATCHDOG_PRETIMEOUT: Recorded when a watchdog 
>> pretimeout fires, before
>> + *  the pretimeout governor brings the system down.
>> + *
>>    * @PSCR_REASON_COUNT: Number of defined power state change 
>> reasons. This
>>    *    value is useful for range checking and potential future 
>> extensions
>>    *    while maintaining compatibility.
>> @@ -267,6 +270,7 @@ enum psc_reason {
>>       PSCR_CPU_CLK_FAIL,
>>       PSCR_XTAL_FAIL,
>>       PSCR_KERNEL_PANIC,
>> +    PSCR_WATCHDOG_PRETIMEOUT,
>>       /* Number of reasons */
>>       PSCR_REASON_COUNT,
>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>> index 979ecf3b093c..fad4ef9681a6 100644
>> --- a/kernel/reboot.c
>> +++ b/kernel/reboot.c
>> @@ -1110,6 +1110,7 @@ static const struct psc_reason_desc 
>> psc_reason_descs[] = {
>>       [PSCR_CPU_CLK_FAIL]     = { "cpu-clock-failure", 
>> POWER_ON_REASON_CPU_CLK_FAIL },
>>       [PSCR_XTAL_FAIL]     = { "crystal-failure",      
>> POWER_ON_REASON_XTAL_FAIL },
>>       [PSCR_KERNEL_PANIC]     = { "kernel-panic",      
>> POWER_ON_REASON_KERNEL_PANIC },
>> +    [PSCR_WATCHDOG_PRETIMEOUT] = { "watchdog-pretimeout", 
>> POWER_ON_REASON_WATCHDOG_PRETIMEOUT },
>>   };
>>   /**
>>
> 

