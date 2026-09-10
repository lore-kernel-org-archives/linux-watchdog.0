Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431543BB109;
	Thu, 10 Sep 2026 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032618; cv=none; b=NT0pV8MqDfS6KlI7q7sTzQm466u09rt8O5VEjJvgVdOvlHR3wZDBArJo8P7J4pYHnQlSKSb8rX0fatnuMrZDh3qTNUwYqm6v/yGzDMiF4SchHOFzayOTopzybgAaKQh/ZW/BQPHKwN9qQeqaVS6V73244vKP5CRi3vWWBWYQ4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032618; c=relaxed/simple;
	bh=MR7cV9v/+BXaRRCe2zaoNuFnkVlS9yo4lu21g6pm574=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmmwuP8BQKKiJjYw8lteuWIbjaJeVGBymidKLmAPi3erRCAewPC8e38otCFG9Xelui02s5rl0MjfwlfjlBv71Yhyqw/TyN2bKEvUuGhd1JNT4X0rD7tO97ji3jQVxJVXCem174cG4Iv/kAqHfusYT78H3s6oYcGDr2c1m2ftaxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XoYegSwi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XoYegSwi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789032615;
	bh=MR7cV9v/+BXaRRCe2zaoNuFnkVlS9yo4lu21g6pm574=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XoYegSwi4OMl9NFkCFe5E/9YntLWhyOUWpYNfFRulHj/RTYCJNAwjrD5vWy47YlQW
	 mLfCcHE1g6+0K1zSNY6EUvY4OZYOpKpT6uDSzB7+7ot/8B/O9woVRQkys1lFVqdDEW
	 mN+Jiie7yayhCmco1qVbw7LAiWDuEP47jt8pt7Hp+W5iyuis+66EX8HZtdfNjS7TRQ
	 My1JywDzlVr6x72UDWgkbYH5021FSwSUXIL4HynLLIktofPiQz+2yPDoxIaOHOedmk
	 AABC3XfUQQB3qScCuBuExqL7QMru1c94UkStEQOaIz/+t7IHkzC3uIcGbe7ms2Zwxr
	 tTThbWTCV6tZQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0059317E0945;
	Thu, 10 Sep 2026 11:30:14 +0200 (CEST)
Message-ID: <69c41994-e021-4542-9633-6a9e5e55593b@collabora.com>
Date: Thu, 10 Sep 2026 11:30:14 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: watchdog: mediatek: Add MT8127
To: zkh@mailbox.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, zkh1@proton.me,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260909-mt8127-amazon-ford-basic-v4-0-e9af5c420ab1@mailbox.org>
 <20260909-mt8127-amazon-ford-basic-v4-1-e9af5c420ab1@mailbox.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260909-mt8127-amazon-ford-basic-v4-1-e9af5c420ab1@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 21:38, Zakariya Hadrami via B4 Relay wrote:
> From: Zakariya Hadrami <zkh@mailbox.org>
> 
> Add entry for MT8127 SoC's watchdog which is compatible with MT6589's
> one.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Zakariya Hadrami <zkh@mailbox.org>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

