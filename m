Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83D51120F
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677899; cv=none; b=PVJ73iXcJrUs5KhMBEz7MiZAv94IuenY+RBOWljJZMl88JwapLLjLNRrtAaQJmrP7SCV76O82RPr81d61ox1CwGGupl7XFlzTeFO7JCXs/Gc1IXsWYLK+3z1a/V7LYO3D5gY3a7YSA+E6FgVxfcDU54xGIJUrXVqLu/4z/xWgBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677899; c=relaxed/simple;
	bh=6Zboq4cT2y84yPYufagiEkEzfccik/iBkOyKlp5pXB4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L3tr+2OhZukzNSvNfUoyxcn3HUnOOf70uZnUVcxRtPK4lWddYXlky3pf9HR3kjM2xyIy0E/ALclji96iBkCCL/zqYAMqAqZgYYMCzMiAuY0SCWmrokrMC/2q4tllwoQEgTFuG0qWHIEQerVwGwnJZcdxpceBe/o2HB8z/l9e2DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m5Acq4uM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zc90gcJT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m5Acq4uM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zc90gcJT"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7U0Et3684776
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 10:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WuBWHHToL3K7RwYQNdbWwY
	+nhIh7kIQTyJPyvxEIHhA=; b=m5Acq4uMj1KHvZGkR8kFXaqrqXg7eo5p+fte+8
	6bI3G8o59cXGUWCQbTxg+aDnohwSY4tmAn9d1OicbSt+WAnkrBbgwcQ0L4WKmMWl
	MZHtUgkzcnCGLU+6rXCjXHh73bOFMhvVQI4dyWYgjLwTb/69wiil12lhy6Q8y5lx
	AqSV8Ab+8NvF0ienmgXObOSnd3a4nESS/C3JGnNdBYETtwUd3U02ubx++wwpfQNN
	9EITar2pmZoSFDiyzeI4/cQN2AWFapG6O3lO/AYVxqTdAFCW5zu95nmLK7sCoEKv
	ZXURuvgP8YcnMrUeUtwOuZNlcvWgfojKhk6khDxew+VFmTQQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144tfg9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 10:31:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so4170989a91.0
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 03:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790677888; x=1791282688; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WuBWHHToL3K7RwYQNdbWwY+nhIh7kIQTyJPyvxEIHhA=;
        b=Zc90gcJTr+n2grhAgnSrl6tRcVFI2tvsi9YxpFUsIuIxlmNhj+uFrM59aghW6rt6Qs
         QzGAQRMBhr6ikJD2PIUkqWq3X4e1Su77/HByuIaYJebiLtvaWZfowcPRQFVyXeN+ssaf
         Lbbl0K8VQ6wIhT5OMCBu6foY7vJxJRgYmw/ogpkd+j5inCDpMZRR7Pk2NcXrY15cAVsu
         ew2AmdvcldCef5i9oC03r3P6VkqWJVxulx5gIFOdFcrDL5F837BF7/Hhl9jK3ROiEqkW
         jxo3QIL5dL8FDI1MFSYDjTItAtLUIMrntFwwzgRM71aIiB6YMTIiKWxObFMJDD+0xj9E
         ULhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677888; x=1791282688;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WuBWHHToL3K7RwYQNdbWwY+nhIh7kIQTyJPyvxEIHhA=;
        b=CGqnSkCUSKZbaVb75qaa7ACPV3Owkd5O8NbEtU8X/sAO5HchCYQl2s3RYaScmvOoF0
         21wV8dL0EHdYfM7hN/XlMz/sZ3W8Wl/DvdObNXp+q6hP/8Oj+M/bm/JA1tZOt+E+iDiT
         z1a0Y4vktXuziBAdpY657v699YTLoNll8pR2Tofl4Zmut33imLHP4a/2zJqUyY/O7dIY
         hrISdOt8eIX5dBNfha6oUSRzz5cRvj6ou83uwZOERM1AYKk+VvKqNgfqDnp9pLvgbbzH
         RvAtY7aLHMs8oEICnfvWfC0A6sdAm70aGfkWRM3vfJzLNwHqNXVTH5x3cAy1NVtAJRCh
         9QzA==
X-Forwarded-Encrypted: i=1; AKwUvBzEC6Hi4U8B2EqX7dBgfyg6YIAT2OsVCUNo/MJygKdoydmhqFkfLhfff8qcDdNu9/stiSnh8p1kI11BOF7Akg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIeMHduQBebUcf7HT2XXcKzVXrfBQap9jAmAmGQLVhMP02B5tKh
	8cbhpeaJrpq0cQcNeymGArJgzNGziX32Yx/Ac5ji/1mcafaC7Y3lB8qVRUpWtqqms+05t297idW
	/cqqfDe6zoUh/SrI+oJz2ErDwboZ3wC75AUnWFPTxr11SlHFbSUwJo/qHZc9wJ15V0oysgQ==
X-Gm-Gg: AYBFou1YiJYdpvv4TkCyJ9vXXmhqCufEZEuAWz0ndUt+/mhvZj4FmQWSzdfmhL2e6X4
	SIDGkAvMwogK4+sTfUGgdlwE7bmJD4TOYodmb8IZ/3CWowAKT8jWAhC641d4+ap8OOa90svbbEf
	0NaoQrVgGYiYpouNwFJ3AHdzr9lQY3ZrfXGzDJrkoA8kZDre1f+ZnTmblBCNuybimjNLm0vbmJh
	TE5mGPJVEiwDR3S6fnqU7bKB0x7T/g+JRiUlLCeqvZSWzYFU0pFt6WQOcPa8oDA3aY+4Sjb4iiM
	zmYFzBx2FuJSDVYIstAMoi9W/pxXQTK9xftTjOhFdoblXO7wveyXcwmMGeeHDc0S58DA/QLRIgQ
	kzRsVp55aN/xrOA==
X-Received: by 2002:a17:90b:3a46:b0:3a2:b04e:8086 with SMTP id 98e67ed59e1d1-3a2b04e8389mr3606752a91.44.1790677888311;
        Tue, 29 Sep 2026 03:31:28 -0700 (PDT)
X-Received: by 2002:a17:90b:3a46:b0:3a2:b04e:8086 with SMTP id 98e67ed59e1d1-3a2b04e8389mr3606726a91.44.1790677887783;
        Tue, 29 Sep 2026 03:31:27 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a492dfc5absm2470791a91.3.2026.09.29.03.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:31:27 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH 0/2] arm64: dts: qcom: sm8750: Add watchdog support
Date: Tue, 29 Sep 2026 16:01:20 +0530
Message-Id: <20260929-sm8750-watchdog-v1-0-ea06d5dc7e54@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHiTu2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyNL3eJcC3NTA93yxJLkjJT8dN00MzOzJINUE2OgsBJQV0FRalpmBdj
 E6NjaWgCZ41eJYQAAAA==
X-Change-ID: 20260929-sm8750-watchdog-f666b0e43875
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790677883; l=657;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=6Zboq4cT2y84yPYufagiEkEzfccik/iBkOyKlp5pXB4=;
 b=CPxKRN+SRfNGx9D8zFn3yOCXAefiaCsFOITRfQoELYm+zrFRlpYM708iTDnB/u05hlu2Zp4NH
 +QD+Ex9wD1cAbsdeUrZBZgR5keXDWzrflDLpn0XQFjQ1qVdj5G06pvp
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0MSBTYWx0ZWRfX28PpPrTttfLi
 FJR1oP9ItO5gdAV9jWym0zTCO08yYMzE2EDxJgF2yut6slOwLFxNchZLjn+9sxcs4NeDhTNCbg/
 GLxZ5i/bKqcQtoVHkBZthK2s4QrR/Yj6qD1mnpIAj5UarZSn4UsGt5S94hqwer2HZkZ+qyL3J3O
 lc/gvTVFSDFHN1s8wxR0PqaNE/DYhTSS0vnmBGneFVYIHYaxyzCUDn79Ww6dzFvpalg+GmcTkFd
 pwjzDstof/PGT2qXdFF43MyskwOdMorlYp1A6CTo+L/LYpwOuLu9IewGD3V0wLRSa3yxFlNEVhh
 ZIF4KqRAs9y+i7In6W6kYiz1Z2LrkfwYpmGe+qrbkgkCfk5DVq9R6hKUkT+5p/1CGUUb6ulY7/k
 iKcPb/XssmjAlzsyweWrmcIqG+s1qvvVIcV3Abj9+oHw23mGMKs+7QHTvixcnWqaQEA7wuend7D
 k8xon/c/CZSHR4dfI8A==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abb9381 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=gH04VMV99jTEonyKTDQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 1cmu-nTAsfoPfCBlWVlw3NPQXLPJbp4D
X-Proofpoint-GUID: 1cmu-nTAsfoPfCBlWVlw3NPQXLPJbp4D
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0MSBTYWx0ZWRfX3vq2KyM5xC5Y
 OibVjF2DeFLdLGOcSIdWcK6pd1bdSn1F/vYGpuLeJvkUN9aDlNDuOKkTpTzf5Zhjr8xuwNVpUag
 RrmtBU9SVOdEhx+2jEnPzslG+1PhYhA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290041

This series adds Qualcomm SM8750 watchdog support by updating both the
binding and the SM8750 devicetree.

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
Komal Bajaj (2):
      dt-bindings: watchdog: qcom-wdt: Document SM8750 watchdog
      arm64: dts: qcom: sm8750: Add watchdog node

 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 arch/arm64/boot/dts/qcom/sm8750.dtsi                     | 7 +++++++
 2 files changed, 8 insertions(+)
---
base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
change-id: 20260929-sm8750-watchdog-f666b0e43875

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>

