Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169412;
	b=naabSJPr/pkiCtKboDSuhG5PcmSKGPtwUrUNJBkCEapTvYeacUSP1FKIspEh2q3fvn06
	 jgxx259pUza+/FBdBMHMM0kYGyXvh7YxrJ17/+GmbeZi4oupNxzvV1dEdsxUYBtatnF2n
	 CyimytwAPbiGJy06JJx8IqE9Om93VklmmcG9zm4lt5uhibeolY5rAzGXNc4oSEdU86XUV
	 ndD9FxqKP/wQfEeC2xVIGfvuNWKfHjcgF13br2HDEhBkIQpg4A1OpWITzGEHBwfvrQcuE
	 BpHKHq4YgRKIsKgdp1vg0IoUGNODG4BtJHVkPIIcrlDNn+c+ay4kysDRqnpOoB+IbXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169412;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=omPiQOZaJI0c60/o2S1s3kpUWM+uAh/TY1E5F9dNSRQ=;
	b=3M+4hFQkWF2puGE2zxEftWlhueEv73ubI0gAJlJvPdbCQhhyHJF7nl1mx+sEkKOpufs5
	 aLAWe9w37XZ8csdnqOm6yCDyWhn8wJwIc9fuHpPikH++BEKfLh7+tJrXY1JOZWcf4BIJr
	 j6RDoHL7/htQ+SYVaW0qesMuqSwHgGTIy2hdObjoapHwM23Ibuanjd2FHqyfrggpBQ3Nr
	 2WIK689zY0zL/bs7i5P4yd9qLy3Fwfuv8g7CutxM/cJVeiMJCZPZ8jQB1WAf0+2ot3q5l
	 mfupj3ra/8piWsfhixYaLg9RDd8KaLFKOj7VPekc7os0NqS1grYSQwbnH3R1s/6PJFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqrneJPo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9496071FC6;
	Sun,  8 Nov 2026 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqrneJPo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF6B1F008BF;
	Sun,  8 Nov 2026 20:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169411;
	bh=omPiQOZaJI0c60/o2S1s3kpUWM+uAh/TY1E5F9dNSRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UqrneJPoAeZVau3TQpkyr7BRtoooxiJk+PtfMIGHTD1UiPAzbI8O+0p3zCBn3EF1Q
	 jIelwHLk2UnGzSQxERSe0MlPVl+NgDabYdX7JzZ3NIQdueReYHl6KyXYVoanYAGi0/
	 /rL/0/D8Mocnfw9afURwRIBgUrRLETUWRqxKQDpoRsVbb+y5azr8Q4gPHRSxngVIp7
	 bxscSOm2OQhy54D08fc/Km7rFcHLfc62AdjuiNBArCjjmg6qvl5YYNcdIP6PlNkRcL
	 l0ubBgiBv8zkTGoErkthuLykbL7s9S1hlF86R8YRLaj4LUBMbTfcnL25c1w97eFANQ
	 gBQDgoT8wYw5g==
From: Bjorn Andersson <andersson@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/2] arm64: dts: qcom: sm8750: Add watchdog support
Date: Sun,  8 Nov 2026 14:20:16 -0600
Message-ID: <179416929293.628393.12758360714321388374.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930-sm8750-watchdog-v2-0-b16fcda275d2@oss.qualcomm.com>
References: <20260930-sm8750-watchdog-v2-0-b16fcda275d2@oss.qualcomm.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 30 Sep 2026 18:32:04 +0530, Komal Bajaj wrote:
> This series adds Qualcomm SM8750 watchdog support by updating both the
> binding and the SM8750 devicetree.

Applied, thanks!

[2/2] arm64: dts: qcom: sm8750: Add watchdog node
      commit: 6554c11efd6dc54583af80808db445be43f55a23

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
