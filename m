Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8098488223
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885610; cv=none; b=V17uh3nnu+BhrwVvNU6Uy+Hb2nnwy9mB41DPzlUdxStUmHZtxjQ/uvVGdKYuNI31B5FUttDWpbrGhlx6X8qH9faCDH8kROZ+QqB/ljDpgF1hPZ52R/XkcmeAo9FYlzFH18NryGEmpQpxt+KsDhXU9y0qFLWHTY9xFS4LOW1gCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885610; c=relaxed/simple;
	bh=tPuke9GZue1598rJs945YYEbvnGdQO2FD3TmVsXbGg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mhw5cWZl9wFJOBiSvVREb2cfgqptex02X1BS8sWasbWPSj2LtprdqxWDUPGa+9pQyC1W01mHPjeSToJGyd6vDjz2wuKX7gLxyaLfRgF6qxZLaZ9XGiaQEpks2i3OgSiQaNxtmqrs2d9Z9PAa/Z0xKuyJotBhCNBj0i3Tzi0alR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HIAk8UvD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ON5Sbcg/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HIAk8UvD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ON5Sbcg/"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8HQ8a988760
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 10:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8y+WbrICdIVcc2cdFgNnGMMKkbi9rFEAVmEY4pqLGkA=; b=HIAk8UvDljORE4jX
	4/vr0PByQOq/FC2imvFYV30TGaKOC5OsHNY6mGoV9r9vLRSIkz7fe42rJkls406f
	XNdnn+9MuVMLAsXj2m8/RN/0LKTQJop2dUvqK12WHyMwXlzU6CtIzLjUcfnjcWOK
	7hbC0HVYuonELceH2QW45VDzI35C+BR2qiM+nc0GcnpGNiUmZVmuwT0l6VfrfcUO
	xgRNxVUcuucOJU40qWRT7AKOV/YIGmRaA1NeZh6E+v8hJfKH7+g390Ff5yc/niZ8
	eoka+PggHkPly8uzatMw/TWPzhvr0fwBc1FdNsYnqzlhGNubYYMOHZGa9InFzqVc
	po1c7Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98hcaakc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 10:00:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934963b2bc0so545228285a.3
        for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791885605; x=1792490405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8y+WbrICdIVcc2cdFgNnGMMKkbi9rFEAVmEY4pqLGkA=;
        b=ON5Sbcg/IkOxTEqL9l39RNefOphsxQIVoCJ06ts/KcC22sWrXcKlVlYVvkYkmgiTG3
         M+gWaPCcyqKpS69c8U4QuGTgBkgLziwjlsk/f1pKa2Rf9QMmG4uJhnbaTdMp7DTztRQ9
         fhg8NJNNRt5WyjE+5hfVDvghGRaOB2of3aD2IwMyHwJB153myPfOVoVY0wIbyPQiLTFO
         9MgB05ywVCSZj1r23bthQ5cAoLH4ZjZkZsC+j9MN6VPClvyWqhcDjLJHOSHOc/qwswXW
         TKiNz2/iaPVV8kFs1wkocUwXQ1faQB4CAVQL9TY5q31c5/2hn0cZ+52G3FT6mT43UuYT
         KOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791885605; x=1792490405;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8y+WbrICdIVcc2cdFgNnGMMKkbi9rFEAVmEY4pqLGkA=;
        b=lpKpIEy9WuO8f8zuVMrS4nexrS7OQd7j9PGxo3d4TSL232LqwZgKNbvAh/AWxJxBKL
         8brZpMOqV9cg2I/jGMgLeySeEL2QiGnmkTwaic/NxiTUUXN4MFs78U+M6GXeSKotiPjT
         axqYvfCQlcj+4+s655XRDhbX2NCEWjCf2S1zZ7BD3ING50ANA4+L4gVngzKxaJXd/Aiy
         83X+EjiSEZ+pY5wViCbprgPFYkRztTKNd7OfcR53f1g1Qmb8BhXUT5s+ezoPbihTpGRw
         u57ky5kI9CyMfzJp8acHhk5VFHNX+Vv50GvgSdAa3lijsslI18zwcwFW/r44dht2S+ag
         qEWg==
X-Forwarded-Encrypted: i=1; AKwUvBzx1FmmlxUKSUG2jGPsvbPNHfmDBfpGByQMenlqP53S9ZTMl/T4eNdoBchwulddpPBnA1rLrtgcvPunihTnqQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLb5DKqDmKfzCseHa/svvMP9Os5gEviCArnLzb+W2Y8Mujrdo8u
	02K6+ScMX6jkg1dyK/gGuMTLLrmG06DXXFder6EIy7KuZuFim3DtXP1OcZBpu905wGB0Ug68IkB
	3ExF0xNC5zX6zMXs6fIo+0t1uxZ4SN2W+GFrsZP877xLuz0pPwvu7/dMtleOL3rG4QEmN1Q==
X-Gm-Gg: AYBFou3GUxs98jJdNnN/FONkF6qDgx/xyLQQsW4bsq1zPaYbSZ2B6UM1snHL80qLLTw
	7L9c0rJ3FJJq0rn8sC3b0On1qIcc2LZ2sfIMKFYulRM9CYYec2yWDwkAxdv6bCs4jLJATczeZjD
	UKKqIuLKMDHQLw8G0+mhNEXsBZEQD9JFsYGb2ZSOzg7cRqBZVZYFKYUYj76i0BEXGhHnFSOJBDO
	JHscx99eARs3XbTPUh2AdFoCJVNCjJVi0fbsBlmAFYdkoKFySMAoOgZPQFWLLeIdKvXYZSq9V7P
	tBpF+hnpvuGbECpcD7YBouSDZPwzUcDPVkimz4d9+JLrTeYZhm84tNeQzo3n+Wa+GDIReya1xdr
	myVj8Q9F32i6C5i1VSYsm2pBjR5tUmi72XS8Av21oEZsfJSvJxTHl8q1Q84H8Rg==
X-Received: by 2002:a05:620a:271d:b0:93b:c537:fdb8 with SMTP id af79cd13be357-93ebd0df02emr1885361885a.6.1791885604861;
        Tue, 13 Oct 2026 03:00:04 -0700 (PDT)
X-Received: by 2002:a05:620a:271d:b0:93b:c537:fdb8 with SMTP id af79cd13be357-93ebd0df02emr1885354685a.6.1791885604246;
        Tue, 13 Oct 2026 03:00:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaaebsm4390052f8f.14.2026.10.13.03.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 03:00:03 -0700 (PDT)
Message-ID: <f01126d0-4ad6-4f23-bf00-88521cd0c2b8@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:00:00 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <07562f41-c269-48b7-9ca2-be324282a456@oss.qualcomm.com>
 <8774f401-7efa-4577-8d03-6fe652e856e3@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <8774f401-7efa-4577-8d03-6fe652e856e3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzOSBTYWx0ZWRfX2k0kha5oNJgb
 70ABqbt+G4zAN+fv3xGpluSnWwAW/ipzdWNuqjpZknlnKu1bZYb9JFNiPj4UpiArbx6e7PRQ+lt
 JLROILWwuT8SN0faWO5+Dicr4HdvCDYKnBp7dTJXapUXYP6fH95AROUJA6OENULTD8+UIqX+WQ0
 fUfnERUBAwjEYBemDab/oxq7+60tmwTi6UUYpluh9aZ3bJGhm7Ki1OudR+Z4kValqsmOZOMvm88
 o4ioJMrvO5pDRIKLUZTpu4GWOPu1DRKpHupB618vK98gDMRqVx+MFOlEd0iIKUGSYE+q3ql0+0L
 +4Cw1fmCox8yJlGa/YerY1fdYfJhQQeaAvbziCVDZXyTpsiex+LfmylQmkYLUtXvhaew2zzptcs
 PS6Bsi36ykRqgY/wj8DeJUoXmqwwfWPDz6+j/SlzyZKUy/woGONZrJew9o9+KBBcrjjEf8lUtu7
 4fZhFrhdVkIoQnk5WNw==
X-Authority-Analysis: v=2.4 cv=VPVIDNPX c=1 sm=1 tr=0 ts=6ace0126 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=a5JEe3mAxTw7QyptA7EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Vf9Ovw9i-Skoa7T14FhzH9iGSHHOoWh1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzOSBTYWx0ZWRfX5fd/9biiSU4P
 KytxNvDcYwFvOSdtoWG6d9YQPuERXVWGdBhT8mwG5xzRlMyszVwYBtOmHHhsJlwNgAN2e619cIg
 1ylMIB46R3mliHYqSz7+7cRaGKEZj1w=
X-Proofpoint-GUID: Vf9Ovw9i-Skoa7T14FhzH9iGSHHOoWh1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130039

On 10/12/26 13:06, Faruque Ansari wrote:
> 
> Hi Daniel Lezcano,
> 
> On 07-Oct-26 4:24 PM, Daniel Lezcano wrote:
>> On 8/5/26 10:54, Faruque Ansari wrote:
>>> Watchdog pretimeout resets are not recorded with a dedicated reason,
>>> causing subsequent boots to report PSCR_UNKNOWN and making it difficult
>>> to distinguish them from other unexpected resets.
>>>
>>> Add PSCR_WATCHDOG_PRETIMEOUT as a dedicated reason code and prevent the
>>> panic notifier from overwriting a watchdog pretimeout reason with
>>> PSCR_KERNEL_PANIC when the pretimeout governor triggers a panic.
>>>
>>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>>> ---
>>>   drivers/power/reset/pscrr/pscrr.c     | 11 +++++++----
>>>   include/linux/power/power_on_reason.h |  1 +
>>>   include/linux/reboot.h                |  4 ++++
>>>   kernel/reboot.c                       |  1 +
>>>   4 files changed, 13 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/power/reset/pscrr/pscrr.c b/drivers/power/ 
>>> reset/pscrr/pscrr.c
>>> index 8c45b84059a9..b7e6239e207e 100644
>>> --- a/drivers/power/reset/pscrr/pscrr.c
>>> +++ b/drivers/power/reset/pscrr/pscrr.c
>>> @@ -529,12 +529,15 @@ static struct notifier_block pscrr_reboot_nb = {
>>>   static int pscrr_panic_notifier(struct notifier_block *nb,
>>>                   unsigned long action, void *unused)
>>>   {
>>> -    struct pscrr_provider_dir *dir;
>>> -    set_psc_reason(PSCR_KERNEL_PANIC);
>>> +    /*
>>> +     * Do not overwrite a watchdog pretimeout reason already set by the
>>> +     * pretimeout path before it triggered this panic.
>>> +     */
>>> +    if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
>>> +        set_psc_reason(PSCR_KERNEL_PANIC);
>>
>> It does not sounds correct.
 >>>> May be you should move the set_psc_reason() to different places for
>> panic.
>>
>> I did not explore the panic() function but I would suggest to have 
>> something like:
>>
>> panic(..., ) --> defaults to PSCR_KERNEL_PANIC
>>
>> panic_with_pscrr(..., reason)
>>
>> Then pscrr_panic_notifier() only does the record
> 
> Thanks for your review.
> 
> I agree that handling the kernel panic reason in this notifier may not 
> be the ideal approach today. However, my intention is to add userspace 
> crash recording support in the future as well. Since this notifier 
> already serves as the common point for recording restart reasons, it 
> seems like the most appropriate place to handle userspace-triggered 
> reboot reasons when that support is added.
> 
> For consistency, I added the handling for kernel panic and watchdog 
> reset reasons here as well. While they are not strictly required for the 
> current use case, this notifier is the most suitable place to record 
> reboot reasons. Keeping all reboot reason handling in one place will 
> also make it easier to add userspace reboot/crash recording support in 
> the future, without introducing a separate mechanism later.

I understand the purpose of the series, but setting the reboot reason 
directly from this notifier does not seem like the right approach.

The notifier should be responsible for recording the reason, while 
determining and updating that reason should be handled independently, as 
it may originate from different execution contexts.

The need to explicitly check for PSCR_WATCHDOG_PRETIMEOUT before setting 
PSCR_KERNEL_PANIC illustrates the problem: the notifier now needs to 
know about other reboot reasons and their relative priorities.

As more reboot reasons are introduced, this approach will require 
additional special cases and become increasingly difficult to maintain.

Wouldn't it make more sense to centralize the reason selection policy, 
keeping the notifier focused on recording the selected reason?


