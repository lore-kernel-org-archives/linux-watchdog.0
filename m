Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B423812D5;
	Tue, 12 May 2026 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589816; cv=none; b=ZqQXbXiv3GCkrcEU0y/bORIW5NR0HPgUNY6VBMTT89m7oDSKCR4ecxiMaFwDiaWWMPXpLureslVoYMPzXbz7pegVspKu33zMyaDW9F5hmYQK+Q8M1BNrvjYoS8ohhwst+SyOU49Zn+aVnLPr/TCrvV8z6a5OMwLXXf4rDLjqhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589816; c=relaxed/simple;
	bh=2QFBCHYyty2qN+25qgGRIXMyA1GhvT3dUvnWU7zN7I4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=GpwwyKvOL6hBrpVOSUD9Irt/VH5NCFtLVkxGgRfHwVNyt6LYmt0Dd2vg2tYHVMmvZzIFgmKKsZLzU9k2nuaD0xQq9KqstzaxQpyhnigHXHAafAvu3/o3vjHqkHZtCvDtCrZk+AnXj9N55EvM3hhN93BNvByk6m2SYG1Zxrn0EuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUWXuirH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUWXuirH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD6AC2BCF5;
	Tue, 12 May 2026 12:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778589812;
	bh=2QFBCHYyty2qN+25qgGRIXMyA1GhvT3dUvnWU7zN7I4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=OUWXuirHD0CE+k/yAj9LpL/EUyljCYOU325FrOcAfsJZoZRFE3xuDgQSk4dJKz76O
	 otTAP9zMd9Q5Ouah6wjlWEPQ3LEsus+C/Whq4YJrRUBnqlsKtXK3t/TVbsi8H4Nvhy
	 7S0UqDcvvZTSGl4PPhurb+fvrdw2+8LLYKNtjlZ4HMnRLJukem77E6iR0NgV/TGyRb
	 OAuL63GoUyUks0XJWgqDfkRmSEeRVQeHo9GRABdO62RNV7eQr67zr6RIkTmf+lv9Fj
	 j+SUuyvvAUGZAUZvQ7EcqamgmgRL4SVzrEfmUksgrLsv8AATr7LqWMVXMF0n2VI6FF
	 jFprVnil0Bl/Q==
Date: Tue, 12 May 2026 07:43:30 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Rustam Adilov <adilov@disroot.org>, linux-watchdog@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>
To: Sander Vanheule <sander@svanheule.net>
In-Reply-To: <20260512110848.106620-2-sander@svanheule.net>
References: <20260512110848.106620-1-sander@svanheule.net>
 <20260512110848.106620-2-sander@svanheule.net>
Message-Id: <177858981010.1472205.3902733449598892024.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: realtek,otto-wdt: Add
 fallback compatible


On Tue, 12 May 2026 13:08:47 +0200, Sander Vanheule wrote:
> As all known hardware instantiations of this watchdog behave the same, a
> fallback compatible can be added.
> 
> To remain compatible with existing single-compatible bindings, the
> current compatibles are duplicated. New compatibles should only be added
> to the list with fallback.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
>  .../bindings/watchdog/realtek,otto-wdt.yaml   | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml:31:13: [warning] wrong indentation: expected 14 but found 12 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260512110848.106620-2-sander@svanheule.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

