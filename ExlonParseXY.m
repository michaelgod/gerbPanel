%     Gerber 274X Panelization script
%     Copyright (C) 2013 TAO-YI LEE <tylee@ieee.org>
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

% THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED 
% WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
% MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
% IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
% INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
% HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
% STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING 
% IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
% POSSIBILITY OF SUCH DAMAGE.

function result = ExlonParseXY(fid, tline, x, y)
    result = tline;
    if(isempty(regexp(tline, 'R', 'match')))            
        re_XX = regexp(tline, 'X(\d+)', 'tokens');
        re_YY = regexp(tline, 'Y(\d+)', 'tokens');
        if(~isempty(re_XX) && x~=0)                    
            XX =  str2double(char(re_XX{1}));
            result = regexprep(result, 'X(\d+)', ['X' sprintf('%05d',XX+x/100)]);
        end
        if(~isempty(re_YY) && y~=0)
            YY = str2double(char(re_YY{1}));
            % disp([strtrim(tline) '  (' num2str(YY) ')+(' num2str(y) ')']);
            result = regexprep(result, 'Y(\d+)', ['Y'  sprintf('%05d',YY+y/100)]);
           % disp(['C-->' strtrim(result)]);
        end 
    end
    fprintf(fid, '%s', result);
end