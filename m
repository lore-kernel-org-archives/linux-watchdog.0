Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B543412C0D;
	Mon, 20 Jul 2026 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553074; cv=none; b=ZJJco/Pc3C4YX2uJ+K8sM/nGz3E+LE33PM2fRNBvu+1kCqyHEQ66pyq9Lh5KsHddAR1O+N+CG6SzJqcgX/PCS9Aa8+wYM1L3+Jb+HTDCVH5KXidnogWThd34AInMhqp7jCFfzQbsVSrCMDI6qq8BoyZXZqD1915Xka6TNmjt9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553074; c=relaxed/simple;
	bh=9KyVBD8Wk5cUPrXz3Wk18pJ4qJEyElw/o8p4FCDFnx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHApNW4rQ2R1ylni5ggQ2i/SUpKLPPPk9P/uKehEVW9b5E2ur4Onl91UTZxf7b2I35hgXRLZfE2hpZUlXCMk5894/7t1LP/NARHJwBOKfeJWtgW01lVQfMvZuFXUe9YBVMHmINpiW59uW/6cNUWAutGUJRwDWA4d9UYw2/4+SpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JJ8cOPvr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JJ8cOPvr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784553070;
	bh=9KyVBD8Wk5cUPrXz3Wk18pJ4qJEyElw/o8p4FCDFnx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JJ8cOPvrzp2Uoh7WBuKlVDJBLMCESDfmTRE6efMLydtMO4Rb8knKVQBA3wGk7NujV
	 aLI5yU6wehgjLX+hYGB6SGWPuqIK5hLWma1g8AXCToUJwvKCGnJ1x0omgTt4sNyStz
	 mSBgbIfkgBLF4KqSVQACXYpYqVon09iqRpcUr6e5fiyjkQmIFOiC2rOs8HRwAXwR0R
	 Rxzhsi+jiFtGoS+osbrEjNHXES9WvHF1b9qw54gc3K+L+VNsdUVG2Wqibk75xE3IGo
	 avAtKJmCEztGMcQrLv9PKUNCTgjQ4b18Jr7M/p2grmILTKPxsrXjlPLjAjMdWbWVzO
	 2R4EXf/jRTUIA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2ED9517E0D87;
	Mon, 20 Jul 2026 15:11:10 +0200 (CEST)
Message-ID: <486a32c0-d940-47f9-8675-4e10a87ce38a@collabora.com>
Date: Mon, 20 Jul 2026 15:11:09 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: reset: Add MT6589 toprgu reset IDs
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260717163959.714561-1-l.scorcia@gmail.com>
 <20260717163959.714561-2-l.scorcia@gmail.com>
 <20260720-gabby-strategic-goose-b61c4e@quoll>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260720-gabby-strategic-goose-b61c4e@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/20/26 08:25, Krzysztof Kozlowski wrote:
> On Fri, Jul 17, 2026 at 06:39:12PM +0200, Luca Leonardo Scorcia wrote:
>> Add reset constants for the 12 MT6589 toprgu resets.
> 
> 
> This is not a single-patch patchset. Seven patches.
> 
> So one posting per 24h, so we actually have a possibility to review it.
> 

krzk, that's because Sashiko provides reviews instantly, and people just go and
fix things to make it easier on us maintainers to provide reviews (and avoiding
to see the same Sashiko complaints from us).

That said, this gets into personal preference territory, and I'm not trying to
start any conversation about that specifically...

>>
>> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
>> ---
>>   .../reset/mediatek,mt6589-resets.h            | 24 +++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>   create mode 100644 include/dt-bindings/reset/mediatek,mt6589-resets.h
>>
>> diff --git a/include/dt-bindings/reset/mediatek,mt6589-resets.h b/include/dt-bindings/reset/mediatek,mt6589-resets.h
>> new file mode 100644
>> index 000000000000..ee08c39df513
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/mediatek,mt6589-resets.h
> 
> 
> Why is this header being added outside of patch documenting compatible?
> You have entire commit msg to say something useful instead of repeating
> the subject.

Because he wrote it all in the cover letter... which is something that gets
read right now, but gets lost once the commits are picked - so all context and
explaining are completely lost.

Luca, that's why krzk is complaining :-)

Just write the information in each commit's description, so that it doesn't get
lost, and so that the next one trying to understand what went on with the toprgu
can just read it there. :-)

Cheers,
Angelo
