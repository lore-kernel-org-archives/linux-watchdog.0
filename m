Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F6247A0C3
	for <linux-watchdog@vger.kernel.org>; Fri,  2 Oct 2026 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934342; cv=none; b=hW1hHBWGDmjCgKZxIcR2ktPiAwFMh7P7oTfv56/N4icwzrAps3CFCW5LJoJDV+wGiQyixM2Wy0Jh4gWuZyC9QounTR46kAZUe070/EmzC54cpztj2Vsufs3Z/W3q442ESz5doFsJqyUTDqS7n9Ccb14F3AKaggixatY8i4Alcfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934342; c=relaxed/simple;
	bh=snYA9aXDSdOQC/1lG3zbAL4whipy57vcj+LHhOkqI+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZWUXs+QTk8dMzLDBJIfUR+Q9fC3E9e4o4AF/v/AOxvEiWPUDpQ9U+rwBuPrJWWdYGjzULu6wJdYB83Omg/IiRlCjPwsKCvGa1+V+ihpfqN1PmABRmDOhhUV/3fgZ10BO3yuACBxB22DwphvwISCHy9R35odog/R51A7AtUW7HW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O8ivHosS; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8ivHosS"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887840c529so2547683f8f.1
        for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 02:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790934338; x=1791539138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BOfnNd54gxkA6GBc+RJDeymuQo4if0ervYEWJ+l8ebk=;
        b=O8ivHosSsQ7QYLY6x/LydQs8Ea8WVMcfDc/WfnIwumPZsN0eh1kCMuqU5OOmVIGm27
         GNCgYynqXm4NDD7XYLearQ4QEkbpLznIctMHmbbrkgqfX17bEAxVkqAnXwJkR5s1fIEY
         8A2Tzw7xCnH2nKc97oqTCs2Zx7KGsUk89nzV7MbN/MZcb8pMpdlgiJMMO0qk8yzeEGb4
         BbmVdQCqLMI997LgLgjR0FIzPAO3dvcp/WwYz2fsfDR2rcqgDt+Gp2DgoF+ob/yILs6J
         c5UeJLWQZX2u3vS6eOSob5gp2mbrXw2J8wjnE7O0G67Mz6m5Bo2PgBwdv1zddpN4S2dg
         O+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790934338; x=1791539138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BOfnNd54gxkA6GBc+RJDeymuQo4if0ervYEWJ+l8ebk=;
        b=EhDDnbZrsHpFp6JVsaWIgkRWbtJrLVxfN4xa1/rxm3P8wNnuxa9qryHVLoHloZd7Qk
         RUgCrAoTGxMc5qu1X9YnRp+uI+5/isfc4/H6DhmG47siwhooamocFO/+7wZR2q8Ug+i+
         L/cnpKgY/XixbV3fHDQH+mSBjtkxhNDJJJv84Dqw6aM9RQP16IabdnWt2xOolFbltfbB
         RKHCkQqQJUG4oV4dnS6Mi8medRTWod78hZF+v6PLOlyN8WOuCCxbOca642F13Zw9vNA7
         ejPhZk/n4SAqU+gJck/hDOXcMLWmkQYgyn1zQFnSf8sQ5aONdlA1iaKFgDoLPPWR8RVf
         RjpQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8nJuBNXrnPiRWQG9MpME5QeKtAYfEL3LUCzSaJGkLx0PKI3r4qiM6FHKdPwSdVO+bcVKUfAFuGYxovTNbSQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kEzPzzagWLbUqjDgmUBnQRe2sejaHxtQheXN2i9/zUqNFLWfhs
	Jg5DjwVUAw8BZevFlPzH4gYK4LSSvb4DM5L8ZFGVM+J3GB46524ioL/fanmOgOHKH+Y=
X-Gm-Gg: AYBFou37VPJf9sYDeihara/iCb/szNAkQhgqSotMiugVE/RV16JFhBDTNapVkB6Fcv0
	y9Ry1V9k/Q4GlUjlVqdmSp8q+goZ/vI+x2iT0ecBbPJvnhPiyLqRsmpBXKVpOtU6ZpIp0gAaYpS
	8d78ni2uF478YXWRD5JdMoQSS7nlK2Lq11FhbYhoNVMj//wevpf+7o0oxbhf4aIdZ33UFj+Co2o
	qOcIbF0hzGYbIZheLMmJGRM80jEwYbcrjh4foSJc0unqOVZevxZ+E0Pr3PkCRf6D6H2n1noNJ9z
	aA/yR+gonXcNDR9LBC23hThWUM24bvyttbI0hguzkxTxedFOa3bO46QxrGf3CwUMSrolvvoKWC4
	wqCysjba/T+XgkIy3ZaCBLUxYEPFRj+bYuIYIRGHNYwzdx12XWtNXkSEUEVzgMESVy/uCcaGjMA
	pKnzP0AmuwytBvj7Q9Xx1YM7QWNtnMHexPRdlPDNdCxBo0Q8SOg8RsQH9YIebOvbzzh8/ClKux0
	b1TAtsaTbe7Eb537Ts=
X-Received: by 2002:a05:600c:870f:b0:49f:fc4f:9efb with SMTP id 5b1f17b1804b1-4a02753fd01mr39854415e9.7.1790934337553;
        Fri, 02 Oct 2026 02:45:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280c8bb0sm72705635e9.11.2026.10.02.02.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:45:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 02 Oct 2026 11:45:30 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: sm8650-valve-deckard: enable the
 watchdog
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-topic-sm8650-deckard-watchdog-v1-3-7d7f7d71d88a@linaro.org>
References: <20261002-topic-sm8650-deckard-watchdog-v1-0-7d7f7d71d88a@linaro.org>
In-Reply-To: <20261002-topic-sm8650-deckard-watchdog-v1-0-7d7f7d71d88a@linaro.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=733;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=snYA9aXDSdOQC/1lG3zbAL4whipy57vcj+LHhOkqI+I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqv3084+1uE60Pin25a4HZRsKv0Zf13ql0BJrttCUl
 fRznsMaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCar99PAAKCRB33NvayMhJ0cVAEA
 CeHn0AzIevi4Gk36fT63KH3c6eOxNcSNr8MigHh0yhbfyeSUeA099EXYMLz7mSn6pwfWMAB0tow5Bo
 9tAGWQB+LHTGmd03eLGu3jQmgV2QXqDQwZ/hGsZFzM+KigTKmS5FOQFumx1Zy8agUXXbBFfAmHHwxR
 SO3QO97nQ8Fbr0Lt/VtquU33rIVpyIYkZmEzLAA1up157932JyffBiNVmIPiSKQGih6nG3WNc4X1FZ
 oS1laNsdJcJBXxcA7eYpgnhlCDjubfz1brDFUjuhXCy3EDGjF56HyDBq+L5rgso7KfIhesEsHmsG6C
 J+KvgFGaNN8gNsWZuJfQR1TCJ1LWo/oOdJs0ndhWYDA3j1g7Ov3HS4naU9MVzzbFguoebB3UBNyiaa
 fLPwkYPDjoTEyBJVgpMs1OsXyDdHw5jEnYqAaK3n9EWtWaaRyWNDSxGfo8Xl7pjV4yMV8qh+6yUt5W
 IxbauybuNIw84PbSVM9vvyT5eGEE2dx8+4Rs7Sf+A6UeSVzoW0GrM4Q8AcEmYGqx9TPO6+tH/B+iaX
 sKsTiVHkuPqW/oX7uSF6Y4O35KOiXhGcuGkJMDqsAKa55/tJ++sMJy4poVkD+LIJYBeZHWdyxVoNdB
 X8SlxxfvScW6flwfQX23CQyNcQLH/rn8GDOS1IxyL0bE8A0cL7BmF/Sj9KqA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Since Linux is loaded in EL2 on the Deckard platform, the
watchdog is usable by the operating system and can be enabled.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-valve-deckard.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-valve-deckard.dts b/arch/arm64/boot/dts/qcom/sm8650-valve-deckard.dts
index d25a09e162dd..197f08487974 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-valve-deckard.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-valve-deckard.dts
@@ -1283,6 +1283,10 @@ &usb_1_hsphy {
 	status = "okay";
 };
 
+&watchdog {
+	status = "okay";
+};
+
 &xo_board {
 	clock-frequency = <76800000>;
 };

-- 
2.34.1

