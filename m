Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37211
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755344AbcIMUs7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Sep 2016 16:48:59 -0400
Subject: Re: [PATCH v2 6/6] selftests: move watchdog tests from
 Documentation/watchdog
To: Timur Tabi <timur@codeaurora.org>, corbet@lwn.net,
        richardcochran@gmail.com, wim@iguana.be, linux@roeck-us.net,
        nab@linux-iscsi.org, maheshkhanwalkar@gmail.com, arnd@arndb.de,
        ghackmann@google.com, ben@decadent.org.uk, thuth@redhat.com,
        christopher.s.hall@intel.com, john.stultz@linaro.org,
        sergei.shtylyov@cogentembedded.com, mpe@ellerman.id.au,
        jani.nikula@linux.intel.com
References: <cover.1473795601.git.shuahkh@osg.samsung.com>
 <328de4c08ef23fe13cec88b45e3e1725cfc5c33b.1473795601.git.shuahkh@osg.samsung.com>
 <57D8628D.3070507@codeaurora.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <3eb32f56-eac7-e0ca-0bcf-90488cbff458@osg.samsung.com>
Date: Tue, 13 Sep 2016 14:48:55 -0600
MIME-Version: 1.0
In-Reply-To: <57D8628D.3070507@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/13/2016 02:33 PM, Timur Tabi wrote:
> Shuah Khan wrote:
>> Remove watchdog-test from Makefile to move the test to selftests.
>>
>> Add Makefile and .gitignore to for watchdog-test. watchdog-test will
> 
> to for?

Thanks - will fix that.

> 
>> not be run as part of selftests suite and will not be included in
>> install targets.  It can be built separately for now.
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>   Documentation/watchdog/src/.gitignore            |   1 -
>>   Documentation/watchdog/src/Makefile              |   2 +-
>>   Documentation/watchdog/src/watchdog-test.c       | 105 -----------------------
>>   tools/testing/selftests/watchdog/.gitignore      |   1 +
>>   tools/testing/selftests/watchdog/Makefile        |   8 ++
>>   tools/testing/selftests/watchdog/watchdog-test.c | 105 +++++++++++++++++++++++
> 
> Please use -M when calling git-format-patch

okay.

> 
>>   6 files changed, 115 insertions(+), 107 deletions(-)
>>   delete mode 100644 Documentation/watchdog/src/watchdog-test.c
>>   create mode 100644 tools/testing/selftests/watchdog/.gitignore
>>   create mode 100644 tools/testing/selftests/watchdog/Makefile
>>   create mode 100644 tools/testing/selftests/watchdog/watchdog-test.c
>>
>> diff --git a/Documentation/watchdog/src/.gitignore b/Documentation/watchdog/src/.gitignore
>> index ac90997..ff0ebb5 100644
>> --- a/Documentation/watchdog/src/.gitignore
>> +++ b/Documentation/watchdog/src/.gitignore
>> @@ -1,2 +1 @@
>>   watchdog-simple
>> -watchdog-test
> 
> Why not also watchdog-simple?
> 

Is watchdog-simple a test or a sample/example? I thought this
is an example, and planning to move that under examples?

If this is a test, I will re-do the patch to include it.

thanks,
-- Shuah

