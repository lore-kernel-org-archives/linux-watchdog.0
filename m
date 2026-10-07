Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75848C3FF
	for <linux-watchdog@vger.kernel.org>; Wed,  7 Oct 2026 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369843; cv=none; b=KmEaET1fPmT7OMrviHv05mXmXfrNrozDR8lyN4We6ka8vq7DCB2FidcVNhSsoLVcLBviKedkQRLiOr+MBi0avFu1taij9aqYjVnCWHiY6UTWOtLgksjq5SK8l2zNUpCgNtxSmuRveegCdYY3AIq0USVAOXMPWwNvXQupKuKyqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369843; c=relaxed/simple;
	bh=z30z8EFGdS9MpzWJ/1rGZvI4KgHGfl74E2sgwHNMULc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=potUOyCJzZ4mTS1oNCZVFUkfMvNTfgcjHgZTrFwTR6JRK4vuXe6sV7cUgUi20sWfU3YXV2N1rIbkEy0WSi08nuyXTzCaUt94XM3WHutwo27JCHGkiBVY3tHZZE9kdtAvI415OckJSTYJIyI9VWBIp+BU7BARxT+lfu82Vp819qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V51P7SbJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FjB789pn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V51P7SbJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FjB789pn"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6977jlEQ3686118
	for <linux-watchdog@vger.kernel.org>; Wed, 7 Oct 2026 10:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IMClJZgZh+h/7kyhDwRKLGWenB/OxKGkOyF/L/dIWco=; b=V51P7SbJLvGvEKbw
	/LzCisXFhxbYm9Y+3SaAhn9KcGJxeCifWXAMpjuLwRDb6y/P5bPtP0H/AUjuqR+W
	sAh1OGdxFTBIPy9n/68Tiujzuj4QhAlew6GKLqpPcVFRe8p58hmEmQM1bYHnk3em
	Na/ZT6tTd0vYr8VlNj9D5oPLnIK26mMo4JdmfUiDopAbyzfrZL57+mNgXetdQVKx
	RzaWO2kQt9YJSEFZ03oYgxCbH3hTvp1HTqXipg2W8dGvJQWj+iu58cDsDBETgYMU
	x3UcoZ7QTAt6lA1xpITe2wzmrXZgfjtep7l2DoisJItY3hx/n7+cvbyJ6ndmRdvx
	s8jzLw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c609qd7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 07 Oct 2026 10:43:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e834ff4d0so590381285a.3
        for <linux-watchdog@vger.kernel.org>; Wed, 07 Oct 2026 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791369813; x=1791974613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMClJZgZh+h/7kyhDwRKLGWenB/OxKGkOyF/L/dIWco=;
        b=FjB789pnyHNTqnoZ6X9Lcul3yrmtHClyXztwsGZAww2PlX0LVimgkLqqq0ZUKAGWy0
         r58uilMsnHZVYy1Jet7GAeXTCsm7RDoNc0ashpFOx5sxdUBZZDYkUFNws/RWYl4Q8TgZ
         fZRtG5qlTJOospBG9P/D78KvRQcmB5eYBCDzanlA/UUklqvFuHqUm07kTrQkBYEdpkFc
         n3WgsiPEsHFiYcOurzunWVjDbRnmNtXCBruodciL0/VyqkUb9d7z4PL07QwObJF7ryQU
         PT1Grh0XQWe1+EcQPf4InIXP/ipXXKF/B10DnINJxTbv3SSt5gXZYa0JJh/Z8Y1qJYDh
         P6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791369813; x=1791974613;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IMClJZgZh+h/7kyhDwRKLGWenB/OxKGkOyF/L/dIWco=;
        b=KfqXa7f/kCy4VjE872e+KbPZHjqLyBKDteTjGwMqLHIzC0t4qw43iumGjsnchJoag7
         96zJHBi0mV/I8Eh5lvEcgDVtmBW3fXl42al8uDPrrpzjYuUNVNvGr3DS+hQWUHpt0zK0
         EkjaV8frYBN2l48Jn0d+XelceQbD0QdOSN/xPd3dDnz+LY/z0eLGjtVCTTC34fOwHtIA
         Q4ffRFDwYv8Q8ZhLqghN4ylZhXkHRDdCBG07MuMtSbMp3aj9IB5CypRv+BTIG67yez7V
         a9hRnW4Ga/tMmQXlrqjl4h9PyBJgUjsUfhmLL+uZPBbUGJzjBP1wTIsme4h3O30vBihJ
         MXCQ==
X-Forwarded-Encrypted: i=1; AKwUvByTym5CGJRbqmf/54ZEM1s0tJ83FzRCgHtwbLTN3ivt3bmDoTCAvWNdmUwXwRiX+FUtM/mtt8HBzrhKNlvCqw==@vger.kernel.org
X-Gm-Message-State: AFuF++mneZaUU5trhRbcCIwwmyBoRfOHXbF8wlltJbYNsMfglhiAhpzL
	L89QKpkGIEDAWDkiGRoM/zjGxaNGo/jzy19zdAlvWkHIGOf2s58HtXexvq1j2KXFQSov88C2ouB
	JHjR/6vt7e/SWbW2LVmP1n4SL7gFdCiV8QPuH59COdhfuEHaz5B+j4aX2qjiYcIGuAIGosg==
X-Gm-Gg: AYBFou2aT896b086w+1brXvKMJi0UEm0D4BGE8TkssRsa6+lH2w5pbTH0SX5uXoLKdA
	XBw55SqL2XeJf2UBgqhDAIvTr+nNe8S8asHkzZ5Wv8aPKrKaA0fnWET5u4JnbFYjOOXEBd9KbeU
	fvOVHuz7ovzwTs912Ak9WP0vYArZVPBzVGgaAywGjFvf0teFrbo6l5Yzm/dFxbnkIgko+Mympu1
	IFPKJpPdT1pFaFZM8qIVsWfTkngIWuV46ZYN9XZn8M1mUky2upQdrO+WQTq3nyvMXO/btBpszPL
	fqyrJrYyPMX4C7sCROr3UMUgFrDa97bGcVRmsxBYRikPesiIkVRk9g8CHzWZ5bs+PW7eIMKO0PB
	6FXze/FOEDGnNjIUr
X-Received: by 2002:a05:620a:1992:b0:93e:9807:9784 with SMTP id af79cd13be357-93e9b8201b3mr318315085a.69.1791369812688;
        Wed, 07 Oct 2026 03:43:32 -0700 (PDT)
X-Received: by 2002:a05:620a:1992:b0:93e:9807:9784 with SMTP id af79cd13be357-93e9b8201b3mr318309785a.69.1791369812011;
        Wed, 07 Oct 2026 03:43:32 -0700 (PDT)
Received: from [10.40.4.23] ([37.168.19.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f4eac2csm72420585e9.0.2026.10.07.03.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 03:43:31 -0700 (PDT)
Message-ID: <99cd4231-b186-4db1-a9d7-45926720b16d@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:43:26 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 1/3] power: reset: pscrr: add kernel panic reason
 tracking
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
 <20260805-pscrr-reboot-reason-v4-1-54ef517084cc@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260805-pscrr-reboot-reason-v4-1-54ef517084cc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0eOlYH8IpCHMZTJYcvWyd5szfZFkAi4j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX/YtGjCtBaF12
 KT7X40q5SdLE59MqbYoDzTEZN4z/oDzTzOgAVhW2Z9+J33Gycwt8/YsRfdt1LfPBlicjET3p3Ml
 CfLsSp5iWCwaqbMXZz1n0KJ42OGmXkI=
X-Authority-Analysis: v=2.4 cv=PM+aavqC c=1 sm=1 tr=0 ts=6ac62255 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=YKLnzF1Vlz+PFNxJOoRadg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=NAPdFkqvqfqtUqX-_sMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 0eOlYH8IpCHMZTJYcvWyd5szfZFkAi4j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX3MuXJe2BWwY1
 XxNAwF+5wHiVN7xo5DwFRFVk3c1pdzngl1h/k83A3jGwFo9LgVHfP85rHmnYDyoJZSKDxFgDWZ6
 JBH6+eumFAEvNu4r4GVfA8PecdZWt6FcaPn6CPViV5UaqaCQrFk5lJ3ro9ZHkUwbT7tM19RmZxZ
 4Z/n0AKkBXBPOSG3A6WN1eXCXT3c19qmGPWEhfxH+OB6d07/8ZtnW1B1lGRzrZhvTo7ZXjw4gz/
 K6Bh1bpRxjmMqBdEh6m4qjbtm0798Bj0FjbgtTkd/atexbTR0LouexHD6jKA5CuAo3wqNLP4f2H
 CIFXhnYMqO8f8dGxdN5e6x/FTbLmqvVdwGkl0SJ59/a9sOVQnjxiN55EC0gASqaPAVAi0okzS/I
 4Npbt5xS0OnYOVUCMzP+SAfHjOEYVDovT9GhYtvU4wsT/gEt5Lt1pkWyHgJBZHE7qqYT+MKJln+
 1lwl5uhMtmp/4Mtvf6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070042

On 8/5/26 10:54, Faruque Ansari wrote:
> Kernel panic resets are not recorded in NVMEM, causing subsequent
> boots to report PSCR_UNKNOWN and making post-mortem analysis more
> difficult.
> 
> Register a panic notifier to preserve the shutdown reason across
> panic-triggered resets. Add PSCR_KERNEL_PANIC as a dedicated reset
> reason code and its corresponding reason string to identify kernel
> panic resets on subsequent boots.
> 
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> ---
Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
