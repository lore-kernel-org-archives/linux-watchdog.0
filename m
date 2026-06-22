Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0941379ED7;
	Mon, 22 Jun 2026 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125855; cv=none; b=P8JFhPPQep49BsIjktE5wuhmZF81xsM1KaYzW1hYT+xUvOLn5xldIE4EHCjryYPfVtxJebkfPOYQ7mmFSG+vPDjH8HnS4E5cggoEyKYZYkgh8m514cnPUd59r+DGW8+m5LYFPFQp3+w2isIcetZnd7oxVujG60WliebRmD3VORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125855; c=relaxed/simple;
	bh=knBIb34V109c16R60b+IdNa39hgtob6UwbXEEZnmjno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAcCIB+1Q1aAPJO68KL4rV2o6vbIXagqSk4HWW/2t49X0qT++kO/8gJkEssT/z3G0UbBmqY3d7Sp8LWKFxV7hHm08F1nJB8727yY50qcw4taRuCrfyE2zhYTEvpvxghfPNrS+nm8jfKx0L1DIlTOEW2MqWkrcF+XLR3lZpqj7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sn7jRwKY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sn7jRwKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA041F000E9;
	Mon, 22 Jun 2026 10:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125854;
	bh=BeHcTS/z7AXMwiJASQFJXorWiTpaBk9eiyGNMafLTr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sn7jRwKYodQnEtNuXEzdY0BHPGq+TWV+tnYZMBNkkotfzIp8krj8T+jcHMC0ZmrhN
	 UWbHcpIXdDwpEkuf7d34w8jDD2bNkfP4xUAaoR22ZFRYtKL7qNsOHIFlWEUOezGiFw
	 +1c+SQ1y3+q6K9cLu3mhnCNzX0Dh8jP21lvACK85aEmrkqI/HbsCCWIVuKs0D4ztNl
	 OPoW3rNuNwPkLxYPfAcyvx1Wvb9E+zJb7NjVeY7GsxTSVUu8FB2z9aMbZ01uGHuGMI
	 A6JJrSfZtwDa8dm5w0o7vhMQKehDT4+sxylTg35NG0QE335rWgC5b4SsR39vxsQL3f
	 z16vM3ONKeSxw==
Date: Mon, 22 Jun 2026 12:57:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zakariya Hadrami <zkh1@proton.me>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sean Wang <sean.wang@mediatek.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: mediatek: Add MT8127 Amazon ford
Message-ID: <20260622-holistic-scarlet-bison-23e25b@quoll>
References: <20260617-mt8127-amazon-ford-basic-v2-0-6859e29e72a8@proton.me>
 <20260617-mt8127-amazon-ford-basic-v2-2-6859e29e72a8@proton.me>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617-mt8127-amazon-ford-basic-v2-2-6859e29e72a8@proton.me>

On Wed, Jun 17, 2026 at 10:37:00PM +0900, Zakariya Hadrami wrote:
> Add entry for the MT8127 based Amazon ford tablet.
> 
> Signed-off-by: Zakariya Hadrami <zkh1@proton.me>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

