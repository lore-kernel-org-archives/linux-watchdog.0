Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B63BC664;
	Thu, 10 Sep 2026 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032621; cv=none; b=pdvjHyHqF0XZZbB4HXyQpOphVNrtoH9MZ33E/h7XvLaFepP+unnELWRfTNX3QzLu/UyRYnGCT6DmI2kbBFCUQ91aVbiMmnLGdo9fP/1Ory+dVtZybxkpqq7aEJ4dwDGxi9Bfad5RNACVbDwUrVka2X1RGBg7cW8Ze2mEYEUF+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032621; c=relaxed/simple;
	bh=zRvdzHl8IEtFB205zSAO49VjmRa+ZkiOo7iU4cGtHKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6d1H40Q4jLfP3Vvg+8bYPtUc5MIZkeOjA0OF8YkLbBPHvql36544Aipu+7oZEGrasLWDE+gEIcNtb3gBAykFN7Om/loY9atptp7RkwTq8Lw6sx414Gvr69SVnGbdJ+u7GkHGoEj2hcmIvl9cahbcPMXxmfvs0qDLWKPXNoQ7rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Elrq5Rrz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Elrq5Rrz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789032617;
	bh=zRvdzHl8IEtFB205zSAO49VjmRa+ZkiOo7iU4cGtHKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Elrq5RrzzJLJjhJwzb5Cu/vv6I2zBr3yI0VP6jVbTEqHEIB9ag5DUUvgnED9GaUrC
	 TIyaVdQ5aLwPhol0k1zDYLdw3rHUV3MoMGU9tcpML/6odbE660vsYz1piAfKTUK36C
	 1K4kVufmvNEPYyVsCjVZoMeDEG+74f9MDsCVQX+/IUOPyNplhLmbaN9JCNeVRnJ0S8
	 t6aSknQC0GURfOllw1H021WzZ2EK9xUbDGGr2R3ehlk4Y/CyWzbKW/V/K1vOcCK0PE
	 bhxGbejd3+TfaWE7X2/T8W4MDppSajEEPGEaGMqT2Bl3gCcxgCYPJf8Ux1LbBa/RXV
	 hNsxlMPk7Ngtw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A7DF217E0C7E;
	Thu, 10 Sep 2026 11:30:16 +0200 (CEST)
Message-ID: <f7e00f6a-35b5-4c50-9b3e-a2cec8e435db@collabora.com>
Date: Thu, 10 Sep 2026 11:30:16 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: arm: mediatek: Add MT8127 Amazon ford
To: zkh@mailbox.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, zkh1@proton.me,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260909-mt8127-amazon-ford-basic-v4-0-e9af5c420ab1@mailbox.org>
 <20260909-mt8127-amazon-ford-basic-v4-2-e9af5c420ab1@mailbox.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260909-mt8127-amazon-ford-basic-v4-2-e9af5c420ab1@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 21:38, Zakariya Hadrami via B4 Relay wrote:
> From: Zakariya Hadrami <zkh@mailbox.org>
> 
> Add entry for the MT8127 based Amazon ford tablet.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Zakariya Hadrami <zkh@mailbox.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
