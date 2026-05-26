Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DBE3BE17F
	for <linux-watchdog@vger.kernel.org>; Tue, 26 May 2026 04:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779768678; cv=none; b=JuIX0+0yLhRjHl2sQhoRl8Ool18BXIp+s4/kjpB1XGpJupeITV4rNuwl3yHOJuhmPQf78miEuVtrQoUaotijjHrWcM1dv8x9eTx+oSNCrJqpTuTl3gdG7RvdH4igHo74LmZ9O6awEjYvNqlKvWcInDJRX25ww5XKTQj/OVlZmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779768678; c=relaxed/simple;
	bh=zg2+q2fDT0NKL9NZjoGAUuEpoErO3sAmmrz8TWEM2yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvB/u5r1iPoFF+9KeeMzpGkkoE9QppTxNMnTjT4KoDJNbkXSHRaMKa+8XdEibsJbHqOj6neMjsnHyG2AcpvB7fEppgpSn+tRMbgAyCV8z1BiKdXqmIiocBSt6mQxJfsUtLZs5HK5DuMVLhugm/K+PZ0QZFBiGm4fTdAjCtk60V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ol5aOili; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cYEfBqe6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ol5aOili";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cYEfBqe6"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PGbCM71802476
	for <linux-watchdog@vger.kernel.org>; Tue, 26 May 2026 04:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5sL5l3pfFXSzJMIu2H6ZykjeOR1JERjmI6jvuOGjE9Y=; b=ol5aOiliKX4CIpur
	AvHHSfn8HfkhZjqAyPt/BOPHC2/+w54ByxR1tXZrMK16T6Un+9pfxQHHPiZIAQjJ
	IX5vzq5xFZgZQb/M5KiuN+57N1utMm+DL+sVA74PpyBCiNBVnOcZKuoqgPYYR+gN
	cVW5qyvJnpiSBb6Pj7djyGK1xUU2RNvzssRic3PeHCWoyd9pVv+WvgqBAmPcmSE5
	6JJSm76fkKuoMHEITuL4XdWpaMVGAPR1XArCrUd3vUpQwFVRQk4PF22DufpaWPF4
	Nnct608bVFoJRIYrFvUPTl6j88bOh522/W3qJVRJ/FIuesgZuiq2ihCMXaiOPwRL
	E6b85Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckyqjw4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 26 May 2026 04:11:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-365fc4636bbso20489320a91.2
        for <linux-watchdog@vger.kernel.org>; Mon, 25 May 2026 21:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779768659; x=1780373459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sL5l3pfFXSzJMIu2H6ZykjeOR1JERjmI6jvuOGjE9Y=;
        b=cYEfBqe6IghNvXaGKOjTTB+h/jnM93VlcBPvkJ/NGS+cmDOWCv7ZNJKpHExjxLgQpz
         wGRqaV2RKHEiyclRBh8gCKN/319WysLXf3aYwi06f236VNCFCW6sMUMfr0xbgpxzDoIn
         Kubl2Srx0+VzmGOupAe/ojshlGlJeyMKJD+oQsWWfJt5qNXvoXnJZsXGlBSZEabx2f8g
         7+auILrGOGUagxeiG2wbQkAmTCT5E4vRoQwB6W81CGwSROpGP48oz64jbJ6Bjb9GIwPI
         VkMTdC7mMyce2890FJtiWakYcx+UDyIbDcTI1c3PPesLAlJ6pxSdbPeqjqR0rM7ZbT7P
         15EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779768659; x=1780373459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sL5l3pfFXSzJMIu2H6ZykjeOR1JERjmI6jvuOGjE9Y=;
        b=CGhB91CMHndp2Zki8l56cYh8oevvo4J8MHzkbVUeyb6xTud6DzHFdrAWUxivZpoXtT
         1zB44Qh/XLkzFatN3P6L7Wg284iB+KGVqjtld0IYIX6Uk+PbgxI8Zn9yTm8nwPTBvfXI
         oPwM4gGzmvrJOJV37gZqfQBcYtNpQwaJd2outFYEGaBiyYMPHoVdiPOwj379MEkSiiZA
         9IgadbpZRJQXr6s65FeAyCNshAHhb4JMOeYFVRhkLciNpudQ3jxxjxbJk+m4WBJ6NTyB
         H9sNDp2oYPhpMaCMgZi5/bTe+fPhn4QkaSScO/rSUPiqvmPS14XxL0Bi4loPSkgKfOvn
         H9sA==
X-Forwarded-Encrypted: i=1; AFNElJ+DDLkIUHMina9IqZeOvzmoYAE8zX/mQCEKj+mIFiy/Q9nzL3ITmxCdnlC7TXTVRMVseGE1IjmTO4XNUnPuCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZEMWqqk8Bbg81Q0hFSp4L9Pp29ofZUYfQCOiIHKBrdjeZco2d
	xHXX8VN0CHJ+TcUGA4maNUXrNQ9cBwTK29AKvKVLvpLt7G22r7BdIzAqxsBJz1VRoDJPLew/+4N
	S+6X+fBqZ2vLe/s21cEaG88Ybxi5ycCQ/kSV32WKclxi6ACFig9uKoxDz/QL/bKGw+AKI3g==
X-Gm-Gg: Acq92OGMyfrTwOWuJFkeSl20qLthcBcpWickDLSBbfipnKX7ta6rIeB+elz71YN1xAt
	xxfk55s9xp+RgttRDeZXbN27DAW1/3917c56vph9RaIf+KayrJ5r89q9jGjlHRvEKoDnUEiBeHZ
	xJvlqS1c5MD7ST1iNIpikUMLQ/Kyyvc9kooQVnt4dcYPSZe3dkGW3SifW3crMiyi4D0GEZ8bvue
	NgwrLlhmmna3XzLA3M89AmJ1KW1FYieX8dv/AbAXQ1r68xNzRq548hCBODqDthht5U/dIjgv174
	0DUmX4F8LpczvhTXanrqH7RA6o8F1BDu0UBFJDpl+dPsHFn5KcJGDIqvue36aotfGiCCW1K389W
	tuxtnG1vKAEEfAxTIgg2BviDpH2gZh1BQfv1QqV18nMs+iVTDSWfuNmRSjXs1phbr8g==
X-Received: by 2002:a17:90b:3791:b0:36a:a16b:5f6d with SMTP id 98e67ed59e1d1-36aa16b66bemr7246994a91.7.1779768659419;
        Mon, 25 May 2026 21:10:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3791:b0:36a:a16b:5f6d with SMTP id 98e67ed59e1d1-36aa16b66bemr7246971a91.7.1779768658884;
        Mon, 25 May 2026 21:10:58 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a721c7b92sm10942268a91.12.2026.05.25.21.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 21:10:58 -0700 (PDT)
Message-ID: <51fb3abd-998c-45a8-a058-ab9185d6fd7f@oss.qualcomm.com>
Date: Tue, 26 May 2026 09:40:53 +0530
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: watchdog: qcom-wdt: Document IPQ5210
 watchdog
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260511-ipq5210_wdt_binding-v1-1-859003d48274@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20260511-ipq5210_wdt_binding-v1-1-859003d48274@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RMyD2Yi+ c=1 sm=1 tr=0 ts=6a151d54 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rzHiTKIQvxCi1bN1TVsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: 2-WVFQ8pZdQ9qSJscURW5Ge6d9MZ_RyN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDAzMyBTYWx0ZWRfX/Bmh2p0uSbjd
 hT+SZ7rjItsZKdgKOzBDTPwhHPVKNgi1AowxArW6I11LXlWHTd3TssZG2XMngHUHMXxFpZ19ieB
 qVAERK2x8ZFDYQUtr4CF/3E9R+oJfQm2gxVxLUuMyIz3eOoOLLILyLS3WXXDP2Ii5w/HxIbcx+5
 UoT7uly8OOcYokNVvaGrwyjKkONFdnAF7GD/QkGwBxnu+wIJuZtVtEEbbFdILzyqjyx/5H5sZnU
 7/+4PEGfPHKBKKbqmQpjsr4zuBWE1NeZ9dczjoN5707kcsqYp2JB0vXTO6sLZY8m0d7QA3r4VwF
 khvqQlJY99DQI6521grkxA8j4owGj2/eclzmyOfOLy8To9fwoA2t2MW8JoQneJjkwzq2XPjnun9
 7FAdidiRJfyTZn/25SCzlBYYFi3GIz1V9SRf6nQ0q36vqTst20sllQNzwkd1rYxG4t3KbWGAD7J
 LEOrzNDKU8y8utgb9tA==
X-Proofpoint-GUID: 2-WVFQ8pZdQ9qSJscURW5Ge6d9MZ_RyN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260033


On 5/11/2026 4:19 PM, Kathiravan Thirumoorthy wrote:
> Document the watchdog device found on the Qualcomm IPQ5210 SoC.
>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 9f861045b71e..21f6f7db7f96 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -20,6 +20,7 @@ properties:
>                 - qcom,apss-wdt-glymur
>                 - qcom,kpss-wdt-ipq4019
>                 - qcom,apss-wdt-ipq5018
> +              - qcom,apss-wdt-ipq5210
>                 - qcom,apss-wdt-ipq5332
>                 - qcom,apss-wdt-ipq5424
>                 - qcom,apss-wdt-ipq9574


Guenter,

Could you please pick up this change? The watchdog device node addition 
merged in linux-next[1] is triggering the DT binding error below.

   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
   DTC [C] arch/arm64/boot/dts/qcom/ipq5210-rdp504.dtb
/local/mnt/workspace/kathirav/upstream/linux-next/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dtb: 
watchdog@b017000 (qcom,apss-wdt-ipq5210): compatible: 'oneOf' 
conditional failed, one must be fixed:
         ['qcom,apss-wdt-ipq5210', 'qcom,kpss-wdt'] is too long
         ['qcom,apss-wdt-ipq5210', 'qcom,kpss-wdt'] is too short
         'qcom,apss-wdt-ipq5210' is not one of ['qcom,apss-wdt-glymur', 
'qcom,apss-wdt-hawi', 'qcom,kpss-wdt-ipq4019', 'qcom,apss-wdt-ipq5018', 
'qcom,apss-wdt-ipq5332', 'qcom,apss-wdt-ipq5424', 
'qcom,apss-wdt-ipq9574', 'qcom,apss-wdt-ipq9650', 
'qcom,apss-wdt-kaanapali', 'qcom,apss-wdt-msm8226', 
'qcom,apss-wdt-msm8974', 'qcom,apss-wdt-msm8994', 'qcom,apss-wdt-nord', 
'qcom,apss-wdt-qcm2290', 'qcom,apss-wdt-qcs404', 'qcom,apss-wdt-qcs615', 
'qcom,apss-wdt-qcs8300', 'qcom,apss-wdt-sa8255p', 
'qcom,apss-wdt-sa8775p', 'qcom,apss-wdt-sc7180', 'qcom,apss-wdt-sc7280', 
'qcom,apss-wdt-sc8180x', 'qcom,apss-wdt-sc8280xp', 
'qcom,apss-wdt-sdm845', 'qcom,apss-wdt-sdx55', 'qcom,apss-wdt-sdx65', 
'qcom,apss-wdt-shikra', 'qcom,apss-wdt-sm6115', 'qcom,apss-wdt-sm6350', 
'qcom,apss-wdt-sm8150', 'qcom,apss-wdt-sm8250', 'qcom,apss-wdt-x1e80100']
         'qcom,kpss-wdt' was expected
         'qcom,scss-timer' was expected
         'qcom,apss-wdt-ipq5210' is not one of ['qcom,kpss-wdt-apq8064', 
'qcom,kpss-wdt-ipq8064', 'qcom,kpss-wdt-mdm9615', 'qcom,kpss-wdt-msm8960']
         'qcom,msm-timer' was expected
         'qcom,kpss-timer' was expected
         from schema $id: 
http://devicetree.org/schemas/watchdog/qcom-wdt.yaml
arch/arm64/boot/dts/qcom/ipq5210-rdp504.dtb: /soc@0/watchdog@b017000: 
failed to match any schema with compatible: ['qcom,apss-wdt-ipq5210', 
'qcom,kpss-wdt']

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm64/boot/dts/qcom/ipq5210.dtsi?id=7a473107f9785700a5c57cee69f60c19a9703f95

>
> ---
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> change-id: 20260511-ipq5210_wdt_binding-9f77d959a28b
>
> Best regards,
> --
> Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>
