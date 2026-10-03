Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C630ACEE;
	Sat,  3 Oct 2026 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791037958; cv=none; b=JaV3Ts2Lwr7hlPeuD7iNLuQZGPzF84JpFYsmGhFRkJQNrju9TY2C2kE1NNYwXCYB0al+cm3zTO+8L5NVEHv55fy6qBSyenHImECiW/GXfvfY6Mb6bFwUxAq1IELB74pxD50y8xyYvOJqk6lVcNlybI919FHT/pUjX8tCVrViqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791037958; c=relaxed/simple;
	bh=zrtPBIBhYFpp4Vz3DN9KUgyG5nS5wtaW+5tprYQ6Vn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R74t8ZFqFAcRIkBh9P+zujaPt/UqTyj1MVjVCl2FF6f4uN4i3jou8Kz/XrZTsrjX78yVq1ArMzB6b+xk0qzixqkDUnFadPAsOBhfO3/Yg24xWei+vWETMcapsIzuqtTD9+WPtk7Wh6rR2Bc/3mRizXz3fbKWzZFnpiqHDBlXNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTh4lYM0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTh4lYM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39A21F0089B;
	Sat,  3 Oct 2026 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791037956;
	bh=xvmvm5SlegXuNYPW+nGgskmwKTjFAzZ/ZX72Lx3IFvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HTh4lYM0lYZiJKaYadUFHs7eipLYtMPPcIxUEaPI9GzeUHKgsSjxL5/jlVqhVEd7y
	 Gx+7vpPjKnX9INEh3aaCansC7OR6G6OHeuN3g0DNtlcJ5YluMA+VdZUcZv8my/tknR
	 sVoRkD58VxyfQnZM4fL1pB6JCpJ1I6gmO7BR+CA4lwtFdeNGKiQhUKRC7P9SIQlx+k
	 4j7PzwTTu8cpd9iAbvHa5mZgaNsndEvqbkpz3RDSsFYO8/2p5qGe8ivVakGbNDg8RB
	 Pr1p9pbB8tPkmPEwQ6mWJSyAO72dwEw/r/6G8DcJIPJCHaL3DMvSXhO4R6wp4M9bEV
	 5zkbmExrrm3dA==
Date: Sat, 3 Oct 2026 16:32:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: watchdog: qcom-wdt: Document SM8650
 watchdog
Message-ID: <20261003-competent-tangerine-mantis-caeced@quoll>
References: <20261002-topic-sm8650-deckard-watchdog-v1-0-7d7f7d71d88a@linaro.org>
 <20261002-topic-sm8650-deckard-watchdog-v1-1-7d7f7d71d88a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002-topic-sm8650-deckard-watchdog-v1-1-7d7f7d71d88a@linaro.org>

On Fri, Oct 02, 2026 at 11:45:28AM +0200, Neil Armstrong wrote:
> Add the SM8650 compatible string to Qualcomm watchdog binding.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

