Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B24481B1
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651994; cv=none; b=cYL7smu1CfBRsmjFZunloeRJI8wPXg7shXcPcSjNzkwUXT0s74HceGF9DDG0ygqJK+QeCm60JZrV5A06XU70/K1A74JNqpYkWculUbFd68bUB/E+QDigGDDos/9UfArnN157ewaBZ6R4mPS+8i0ApMFzGBoPgT4Rh6NawC+A7OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651994; c=relaxed/simple;
	bh=WSJ1i7xSrurxwxAyDPawNLM8TAMGNP4ffSZ0RFTRNcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRyw+g/fBWvmAECu1+XqrtO1ZQPCqBWF6TOJ5jIy3wmn6dcqFjc9aAqCz+4N3hyQ+T4Oo1uINtheCdbhUEMo5K4jAvTx9CKAvehNTCw/OzR02lQG26QYnnC6LuOBTM3MFE6koSBeeJfs2HIaIVhM6kXQ8pfWMylVPEB///Z5PKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QSZ8ENFl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GS9fnrMn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QSZ8ENFl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GS9fnrMn"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64cYR2128462
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WSJ1i7xSrurxwxAyDPawNLM8TAMGNP4ffSZ0RFTRNcs=; b=QSZ8ENFldnIVHBHy
	Ysga3vpsptWdsAzDiAKCxPbJj2Ae+wfK4AkfsEyOJ2XTAolErxZX0gkQDkf6yeUQ
	0go6ECSYu6GCD5wC2gsMimKeuSIp9XGJ551UpDRF0KI9OGgJpw3olbc1SrJzh7IX
	nomHxZy6Ohyy+YQW3PfgZ6ci6nY1O2i2deBGwSowlITLyu90ZfyDM9ToTvwCZeFS
	jPxU7vn784U0H4z8R2Hae9RpTPMyP1MUklFmjWPGuf27kVl15XvBrr8fChq8mM/9
	ylaCJJImi/jwxgZgPmqX1fNbcQWIQ8we4GiZN4lZ+IMvtRH0iEBgIrViSsEWs854
	OSG2jQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00an0rr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:06:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b056b2f0cfso9601665ad.0
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773651991; x=1774256791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSJ1i7xSrurxwxAyDPawNLM8TAMGNP4ffSZ0RFTRNcs=;
        b=GS9fnrMnHiqkyS8T+CD/i8nH3EGFYqJzRk6wt5XObS9DsbIp08625vl6BlqzVCfvjO
         gwpoDSlnJMcmyfkRlOnxnsWueLusUGsnaQjAZH9dq9RctH8mXHGmC+I8C2kN2zEfQhG2
         bglncR3ZEXu5QkzIlBLQV8RxdXU1juC21QhVtXFKPG0/l1pRoLHAJ1T68vq+HK2yMhYf
         O36biBceEh1MFtNMPCOYxkqN0KpHSx1xc3KVlKAtDLDqTPgkcrsappSH42L876P+tpuG
         DlOCl8FAAXuXRpXs/GXppMHzF4jkgx2D9mdKM67ZA6ttBDiuUHLsybbSxIzUnrweV9TC
         fuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651991; x=1774256791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSJ1i7xSrurxwxAyDPawNLM8TAMGNP4ffSZ0RFTRNcs=;
        b=VF7SQrOwZ1X+3lqKg82KT6dxGnEYaDKNAh/kpwPK798t5CYcfqoBn/xlgjYRHi/XO9
         KbdruWNVH7KsBj+rYgLz2//zgzBJei8EOjm5Wl95hxJXuujKep5MCoKwWCou5CyvMRdC
         10b1BWwmAcsng9//9DZL7y85i6iCXov/uMTg5vfiuF27S7iUjQBtBOYbKIs/zAFCIJ/f
         dZpK6DhakR6pkHK86rw8p5PY8l+DJBmkY769vuyoUrkg/mo0q8O6XIzy7NdEXXBUw+1K
         RtfHJSA6la5v6irQ+WAS3nJV9jgeW32KUke+KjMgWlGx7VKpS3ZF3evIv3ltW8b9DExD
         9HAA==
X-Forwarded-Encrypted: i=1; AJvYcCVZygT6VU8sYbC6QZazHDXq44VlS5Etxcxt4Kl8X6v2sq3+G7/quZemm3DCFC41idnQIm0RI5yAuJL820zAqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwuJtiurlot90Gdvh/g6xERwCeS7MuN62QNQqjkkVawTu9rl6
	Yq7IA/6f/sMOFlFZWcDvsbzgSKiF2Oqlc7PWfZy3DMOZxqbgyuRs869khztzGwcUmCAOknrom3u
	1lhI0gNzwtIoIJJ9AsoTKotukNxCDSc9xRhanfG7xZp/6REHtvaELwx3TWTI46R1VHdEL2g==
X-Gm-Gg: ATEYQzzwtTpYWhjgvAj61H3VpS0b6x88/hLyPw1W7YwULNdvrDGhMPCmiSS2O6zomqj
	VgReqLeLjJcpGEitS6ogJv8YWfZPYkIFeNeBKNM/+VMBcudJtQXc3rzjzh0zSm2YV2rUqLFyxRL
	hOVZnT5Y7ITt5wHglxX0eToxJ7+RM0XiQBODML2XnCnY0rCVcrPQEqgpBCVgV8K3WZTTRy4/y4F
	Qoa/uOqKMXQulHf/QWOZjvuy9hRWpBX7zszQ87CcRtAafLOz0mc0ovn4Aox5TV17KrnQFVa7t/V
	y71gVtFQ+4yw60+2fr8FYDbZtE7iNIjN6SxNlcA/EgI4uZduEA5Mrv8jqgbaYE6rmdc3Gt8yaqn
	ltucUn59THHPfEOESVZDuLqw+97rPZnop4Apf3jUI6LpVAyL33BRSVag0VBO2zlv+xw==
X-Received: by 2002:a17:903:2305:b0:2b0:59c4:e9dc with SMTP id d9443c01a7336-2b059c4ebc7mr23580145ad.22.1773651990995;
        Mon, 16 Mar 2026 02:06:30 -0700 (PDT)
X-Received: by 2002:a17:903:2305:b0:2b0:59c4:e9dc with SMTP id d9443c01a7336-2b059c4ebc7mr23579775ad.22.1773651990420;
        Mon, 16 Mar 2026 02:06:30 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b05db37a8esm19727885ad.29.2026.03.16.02.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 02:06:30 -0700 (PDT)
Message-ID: <7593d19b-c124-48fb-9c0f-af8177dab1ac@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 14:36:24 +0530
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/5] Add support to read the watchdog bootstatus from
 IMEM
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260228-wdt_reset_reason-v9-0-f96d7a4825d3@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20260228-wdt_reset_reason-v9-0-f96d7a4825d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: afGYTujwilTl2Br0-cGFuCKrBu-J6ACI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA2OSBTYWx0ZWRfX/iZObVbgcsjp
 XZG84nfp78WMnmmVrfbHVDlDzYlDmSBE40kfCt0LW6Szq8JNzCrM6z0TzMiL6rqOCsDeYibd24C
 QkhmEhQsELfslhryWg89ou5XUqh+Uw0SVP7K/eHlExxBaHyhyFyjlk2PfT1oj/F7ZPY36vZVo58
 Svh5myZ5eiZGqgG79dyQgoR79lc3pv9ShmVFIcF5B3Aq3s0Nu3YaFw2utNIqpgJD4iYlGiBIECp
 ZQzlzX8ehW/hmZZ6H18/U+y+S9TLgzAzks2XXhmPsiLbFknNnZmsP6EYAuD+61EYQW1X5FdbGpl
 EEleD8AYEQ6EvzJAMAFH36KxARxDfkTVELWJeWmk/5jPsIQt3C4drHNcmG607EoDazEa5+MzFDM
 TKt9J7s2QTMe/xm+buSXxekT8/OGyM8TspNmSy4YOURg4iOLc7GHHENJoEa7NS7uUy160ZzogXP
 UL5nZ/TCiGAltUOm8dQ==
X-Proofpoint-ORIG-GUID: afGYTujwilTl2Br0-cGFuCKrBu-J6ACI
X-Authority-Analysis: v=2.4 cv=ebIwvrEH c=1 sm=1 tr=0 ts=69b7c817 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1iOovS3Ob0lYkPkW6isA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160069


On 2/28/2026 5:58 PM, Kathiravan Thirumoorthy wrote:
> In Qualcomm IPQ SoCs, if the system is rebooted due to the watchdog
> timeout, there is no way to identify it. Current approach of checking
> the EXPIRED_STATUS in WDT_STS is not working.
>
> To achieve this, if the system is rebooted due to watchdog timeout, the
> information is captured in the IMEM by the bootloader (along with other
> reason codes as well).
>
> This series attempts to address this by adding the support to read the
> IMEM and populate the information via bootstatus sysfs file.
>
> With the CONFIG_WATCHDOG_SYSFS enabled, user can extract the information
> as below:
>
> cat
> /sys/devices/platform/soc@0/f410000.watchdog/watchdog/watchdog0/bootstatus
> 32
>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Gentle Reminder on this series. If there are no further comments, can this be picked up for v7.1?

